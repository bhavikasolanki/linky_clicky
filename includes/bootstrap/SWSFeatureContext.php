<?php

use Behat\Behat\Context\ClosuredContextInterface,
    Behat\Behat\Context\TranslatedContextInterface,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\PendingException,
    Behat\Mink\Exception\ExpectationException,
    Behat\Mink\Session;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;
use Drupal\Component\Utility\Random;

//
// Require 3rd-party libraries here:
//
//   require_once 'PHPUnit/Autoload.php';
//   require_once 'PHPUnit/Framework/Assert/Functions.php';
//

/**
 * Features context.
 */
// class FeatureContext extends BehatContext
class SWSFeatureContext extends Drupal\DrupalExtension\Context\DrupalContext {
    /**
     * Initializes context.
     * Every scenario gets its own context object.
     *
     * @param array $parameters context parameters (set them up through behat.yml)
     */
    public function __construct(array $parameters)
    {
        // Initialize your context here
        $this->useContext('mink-extra', new \Weavora\MinkExtra\Context\MinkExtraContext());
    }


  /**
   * @Given /^the "([^"]*)" module is enabled$/
   */
  public function theModuleIsEnabled($arg1) {
    $result = $this->getDriver()->drush("pm-enable -y " . $arg1);
    if (preg_match('/(\[warning\]|\[error\])/', $result)) {
      throw new Exception($result);
    }
  }

  /**
   * @Given /^the "([^"]*)" module is disabled$/
   */
  public function theModuleIsDisabled($arg1) {
    $result = $this->getDriver()->drush("pm-disable -y " . $arg1);
    if (preg_match('/(\[warning\]|\[error\])/', $result)) {
      throw new Exception($result);
    }
  }

  /**
   * @Given /^I wait (\d+) second(s)?$/
   */
  public function iWaitSeconds($seconds) {
    $this->getSession()->wait(1000*$seconds);
  }

  /**
  * Invoking a php code with drush.
  *
  * @param $function
  * The function name to invoke.
  * @param $arguments
  * Array contain the arguments for function.
  * @param $debug
  * Set as TRUE/FALSE to display the output the function print on the screen.
  * See https://github.com/openscholar/openscholar/blob/SCHOLAR-3.x/openscholar/behat/features/bootstrap/FeatureContext.php#L658
  */
  private function invoke_code($function, $arguments = NULL, $debug = FALSE) {
    $code = !empty($arguments) ? "$function(" . implode(',', $arguments) . ");" : "$function();";

    $output = $this->getDriver()->drush("php-eval \"{$code}\"");

    if ($debug) {
      print_r($output);
    }

    return $output;
  }

  /**
   * Override DrupalContext::login
   * The WebAuth Module for Drupal (WMD) hides the user login form in a collapsible fieldset.
   * We need to open that fieldset up to be able to fill out the fields
   */
  public function login() {
    // Check if logged in.
    if ($this->loggedIn()) {
      $this->logout();
    }

    if (!$this->user) {
      throw new \Exception('Tried to login without a user.');
    }

    $this->getSession()->visit($this->locatePath('/user'));
    $element = $this->getSession()->getPage();
    // find the Local User Login link - it's only findable in the browser, with Javascript
    // See Behat\Mink\Element\TraversableElement::findLink
    $localuserlogin = $element->findLink("Local User Login");
    if (!is_null($localuserlogin)) {
      // click on the Local User Login link to expose the user name and password fields
      // See Behat\Mink\Element\TraversableElement::clickLink
      $element->clickLink("Local User Login");
    }
    $element->fillField($this->getDrupalText('username_field'), $this->user->name);
    $element->fillField($this->getDrupalText('password_field'), $this->user->pass);
    $submit = $element->findButton($this->getDrupalText('log_in'));
    if (empty($submit)) {
      throw new \Exception(sprintf("No submit button at %s", $this->getSession()->getCurrentUrl()));
    }

    // Log in.
    $submit->click();

    if (!$this->loggedIn()) {
      throw new \Exception(sprintf("Failed to log in as user '%s' with role '%s'", $this->user->name, $this->user->role));
    }
  }

  /**
   * Override MinkContext::fixStepArgument().
   *
   * Make it possible to use [random].
   * If you want to use the previous random value [random:1].
   * See http://cgit.drupalcode.org/panopoly/tree/tests/behat/features/bootstrap/FeatureContext.php?id=18a2ccbdad8c8064aa36f8c57ae7416ee018b92f
   */
  protected function fixStepArgument($argument) {
    $argument = str_replace('\\"', '"', $argument);

    // Token replace the argument.
    static $random = array();
    for ($start = 0; ($start = strpos($argument, '[', $start)) !== FALSE; ) {
      $end = strpos($argument, ']', $start);
      if ($end === FALSE) {
        break;
      }
      $name = substr($argument, $start + 1, $end - $start - 1);
      if ($name == 'random') {
        $randomname = $this->getDrupal()->random->name(8);
        $randomname = strtolower($randomname);
        $this->vars[$name] = $randomname;
        $random[] = $this->vars[$name];
      }
      // In order to test previous random values stored in the form,
      // suppport random:n, where n is the number or random's ago
      // to use, i.e., random:1 is the previous random value.
      elseif (substr($name, 0, 7) == 'random:') {
        $num = substr($name, 7);
        if (is_numeric($num) && $num <= count($random)) {
          $this->vars[$name] = $random[count($random) - $num];
        }
      }
      if (isset($this->vars[$name])) {
        $argument = substr_replace($argument, $this->vars[$name], $start, $end - $start + 1);
        $start += strlen($this->vars[$name]);
      }
      else {
        $start = $end + 1;
      }
    }

    return $argument;
  }

  /**
   * @Then /^I should see (\d+) or more "([^"]*)" elements$/
   */
  public function iShouldSeeOrMoreElements($num, $element) {

    $container = $this->getSession()->getPage();
    $nodes = $container->findAll('css', $element);

    if (intval($num) > count($nodes)) {
      $session = $this->getSession();
      $message = sprintf('%d "%s" elements found when there should be a minimum of %d.', count($nodes), $element, $num);
      throw new ExpectationException($message, $session);
    }

  }

    /**
   * @Then /^I should see (\d+) or fewer "([^"]*)" elements$/
   */
  public function iShouldSeeOrFewerElements($num, $element) {
    $container = $this->getSession()->getPage();
    $nodes = $container->findAll('css', $element);

    if (intval($num) < count($nodes)) {
      $session = $this->getSession();
      $message = sprintf('%d "%s" elements found when there should be a maximum of %d.', count($nodes), $element, $num);
      throw new ExpectationException($message, $session);
    }
  }

  /**
   * @When /^I hover over the element "([^"]*)"$/
   */
  public function iHoverOverTheElement($locator) {
    $session = $this->getSession(); // get the mink session
    $element = $session->getPage()->find('css', $locator); // runs the actual query and returns the element

    // errors must not pass silently
    if (null === $element) {
      throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $locator));
    }

    // ok, let's hover it
    $element->mouseOver();
  }

  /**
   * This function causes the drop down. No need to add a hover step before.
   *
   * @Then /^I wait for the Site Actions drop down to appear$/
   */
  public function iWaitForTheSiteActionsDropDownToAppear() {

    $this->getSession()->getDriver()->evaluateScript(
    "jQuery('#block-menu-menu-admin-shortcuts ul.nav li.first.last, #block-menu-menu-admin-shortcuts ul.nav li.expanded:first').find('ul').show().css('z-index', '1000');"
    );

    $this->getSession()->wait(3000, "jQuery('#block-menu-menu-admin-shortcuts ul.nav > ul.nav').children().length > 0");

  }

  /**
   * Click some text
   *
   * @When /^I click on the text "([^"]*)"$/
   */
  public function iClickOnTheText($text) {
    $session = $this->getSession();
    $element = $session->getPage()->find(
      'xpath',
      $session->getSelectorsHandler()->selectorToXpath('xpath', '*//*[text()="'. $text .'"]')
    );
    if (null === $element) {
      throw new \InvalidArgumentException(sprintf('Cannot find text: "%s"', $text));
    }

    $element->click();
  }

  /**
   * Find the default value of a select element.
   * See https://github.com/Behat/Mink/issues/300
   * @Then /^I want to validate select field option "([^"]*)" default is "([^"]*)"$/
   */
  public function iWantToValidateSelectOptionDefaultIs($locator, $defaultValue) {
       $optionElement = $this->getSession()->getPage()->find('xpath', '//select[@name="' . $locator . '"]/option[@selected]');
       if (!$optionElement) {
          throw new Exception('Could not find a select element with the "name" attribute of ' . $locator);
       }

      $selectedDefaultValue = (string)$optionElement->getText();
       if ($selectedDefaultValue != $defaultValue) {
          throw new Exception('Select option default value: "' . $selectedDefaultValue . '" does not match given: "' . $defaultValue . '"');
       }
  }

  /**
   * @Given /^I wait for the batch job to finish$/
   * Wait until the id="updateprogress" element is gone,
   * or timeout after 3 minutes (180,000 ms).
   */
  public function iWaitForTheBatchJobToFinish() {
    $this->getSession()->wait(180000, 'jQuery("#updateprogress").length === 0');
  }

  /**
   * @Given /^I wait for the Admin Menu to load$/
   * Wait until we have a "#admin-menu" element,
   * or timeout after 10 seconds (10,000 ms).
   */
  public function iWaitForTheAdminMenuToLoad() {
    $this->getSession()->wait(10000, 'jQuery("#admin-menu").length > 0');
  }

  /**
   * Click on the element with the provided CSS Selector
   *
   * @When /^I click on the element with css selector "([^"]*)"$/
   */
  public function iClickOnTheElementWithCSSSelector($cssSelector) {
    $session = $this->getSession();
    $element = $session->getPage()->find(
        'xpath',
        $session->getSelectorsHandler()->selectorToXpath('css', $cssSelector) // just changed xpath to css
    );
    if (null === $element) {
        throw new \InvalidArgumentException(sprintf('Could not evaluate CSS Selector: "%s"', $cssSelector));
    }
    $element->click();
  }

  /**
   * Press the element with the provided CSS Selector
   *
   * @When /^I press the element with css selector "([^"]*)"$/
   */
  public function iPressTheElementWithCSSSelector($cssSelector) {
    $session = $this->getSession();
    $xpath = $session->getSelectorsHandler()->selectorToXpath('css', $cssSelector);
    $element = $session->getPage()->find(
        'xpath',
        $xpath
    );

    if (null === $element) {
        throw new \InvalidArgumentException(sprintf('Could not evaluate CSS Selector: "%s"', $cssSelector));
    }

    $element->press();
  }

  /**
   * @Then /^I should see (\d+) "([^"]*)" element[s]? in the "([^"]*)" region$/
   */
  public function iShouldSeeElementsInTheRegion($num, $element, $region) {
    $regionObj = $this->getRegion($region);
    $session = $this->getSession();

    $selectElements = $regionObj->findAll(
      'xpath',
      $session->getSelectorsHandler()->selectorToXpath('css', $element) // just changed xpath to css
    );

    if (intval($num) !== count($selectElements)) {
      $session = $this->getSession();
      $message = sprintf('%d "%s" elements found when there should be %d.', count($selectElements), $element, $num);
      throw new ExpectationException($message, $session);
    }

  }

  /**
   * @Given /^I follow meta refresh$/
   */
  public function iFollowMetaRefresh() {
    while ($refresh = $this->getMainContext()->getSession()->getPage()->find('css', 'meta[http-equiv="Refresh"]')) {
      $content = $refresh->getAttribute('content');
      $url = str_replace('0; URL=', '', $content);
      $this->getMainContext()->getSession()->visit($url);
    }
  }

/**
 * @When /^I select the "([^"]*)" radio button$/
 */
  public function iSelectTheRadioButton($labelText) {
    // Find the label by its text, then use that to get the radio item's ID
    $radioId = null;
    $ctx = $this->getMainContext();

    /** @var $label NodeElement */
    foreach ($ctx->getSession()->getPage()->findAll('css', 'label') as $label) {
        if ($labelText === $label->getText()) {
            if ($label->hasAttribute('for')) {
                $radioId = $label->getAttribute('for');
                break;
            } else {
                throw new \Exception("Radio button's label needs the 'for' attribute to be set");
            }
        }
    }
    if (!$radioId) {
        throw new \InvalidArgumentException("Label '$labelText' not found.");
    }

    // Now use the ID to retrieve the button and click it
    /** @var NodeElement $radioButton */
    $radioButton = $ctx->getSession()->getPage()->find('css', "#$radioId");
    if (!$radioButton) {
        throw new \Exception("$labelText radio button not found.");
    }

    $ctx->fillField($radioId, $radioButton->getAttribute('value'));
  }

  /**
   * Find an element in a region.
   * see http://cgit.drupalcode.org/panopoly/tree/tests/behat/features/bootstrap/FeatureContext.php?id=18a2ccbdad8c8064aa36f8c57ae7416ee018b92f
   *
   * @Then /^I should see a "([^"]*)" element in the "([^"]*)" region$/
   */
  public function assertRegionElement($tag, $region) {
    $regionObj = $this->getRegion($region);
    $elements = $regionObj->findAll('css', $tag);
    if (!empty($elements)) {
      return;
    }
    throw new \Exception(sprintf('The element "%s" was not found in the "%s" region on the page %s', $tag, $region, $this->getSession()->getCurrentUrl()));
  }

   /**
   * Sets an id for the first iframe situated in the element specified by id.
   * Needed when wanting to fill in WYSIWYG editor situated in an iframe without identifier.
   * See https://www.drupal.org/node/1826016#comment-7753999
   *
   * @Given /^the iframe in element "(?P<element>[^"]*)" has id "(?P<id>[^"]*)"$/
   */
  public function theIframeInElementHasId($element_id, $iframe_id) {
    $function = <<<JS
(function(){
  var elem = document.getElementById("$element_id");
  var iframes = elem.getElementsByTagName('iframe');
  var f = iframes[0];
  f.id = "$iframe_id";
})()
JS;
    try {
      $this->getSession()->executeScript($function);
    }
    catch(Exception $e) {
      throw new \Exception(sprintf('No iframe found in the element "%s" on the page "%s".', $element_id, $this->getSession()->getCurrentUrl()));
    }
  }

  /**
   * Fills in WYSIWYG editor with specified id.
   * See https://www.drupal.org/node/1826016#comment-7753963
   * @Given /^(?:|I )fill in "(?P<text>[^"]*)" in WYSIWYG editor "(?P<iframe>[^"]*)"$/
   */
  public function iFillInInWYSIWYGEditor($text, $iframe) {
    try {
      $this->getSession()->switchToIFrame($iframe);
    }
    catch (Exception $e) {
      throw new \Exception(sprintf("No iframe with id '%s' found on the page '%s'.", $iframe, $this->getSession()->getCurrentUrl()));
    }
      $this->getSession()->executeScript("document.body.innerHTML = '<p>".$text."</p>'");
      $this->getSession()->switchToIFrame();
  }

  /**
   * @Then /^the response header "([^"]*)" should contain "([^"]*)"$/
   */
  public function theResponseHeaderShouldContain($arg1, $arg2) {
    $headers = $this->getSession()->getResponseHeaders();
    if (!in_array($arg2,$headers[$arg1])) {
      throw new Exception('The HTTP header "' . $arg1 . '" did not contain "' . $arg2 . '"');
    }
  }


}
