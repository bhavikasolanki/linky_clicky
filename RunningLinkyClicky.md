# Running Linky Clicky:

Running the tests in Link Clicky involves pulling together a Behat command with the appropriate options and path. Refer to [Using Linky Clicky] (https://github.com/SU-SWS/linky_clicky/blob/5.x/UsingLinkyClicky.md) to learn how the options are implemented for Linky Clicky.
To get a list describing *all* the options for Behat tests enter:
$ ../../bin/behat --help


To execute the tests for a product/site/environment/etc:
1. Start up Selenium, verify your drush aliases work properly

1. Navigate to the product/site/environment/ directory.
For example if you want to run tests for sites running the JSE product you'll want your current working directory to be:
linky_clicky/products/jse

1. Define the site profile in the behat.local.yml file in JSE product directory.
For this example, the profile will be: local-jse-dev.

1. Use the version of Behat included with the repository.
Because the tests in this directory use this version of Behat, and this version of Behat may include patches, you'll want to use it for running these tests. To access the Behat executable from the JSE product directory, at the command prompt you'll enter ../../bin/behat

1. Build your Behat command for running your tests.
In the documentation above we describe how many Behat options will be used. When testing, you'll need to identify and use the appropriate options.  
For our purposes we'll use the following options: profile (-p), suite (-s), and path, and the resulting command is this:
$ ../../bin/behat -p local-jse-dev -s live features

Go to [README] (https://github.com/SU-SWS/linky_clicky/blob/5.x/README.md)


Go to [Using Linky Clicky] (https://github.com/SU-SWS/linky_clicky/blob/5.x/UsingLinkyClicky.md)