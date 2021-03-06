Feature: Ensure Site Owners can create, edit and delete any news items. Ensure editors can create, and delete their own news items, edit any news items
  In order to ensure that users with permissions can create, edit and delete news items
  As a site owner
  I want to be able to create, edit and delete any news items
  As an editor
  I want to be able to create, and delete my own news items, edit any news items

  @api @dev @destructive @javascript
  Scenario: Ensure site owners can create, edit and delete their own news items
  Given I am logged in as a user with the "site owner" role
  When I wait for the Site Actions drop down to appear
  And I click "Add News Item" in the "Admin Shortcuts" region
  Then I should see "Create News Item" in the "Branding" region
  And the "Text format" field should contain "content_editor_text_format"
  Then I fill in "edit-title" with "Foo"
  And I press the "Save" button
  Then I should see "News Item Foo has been created" in the "Console" region
  And I should be on "news/foo"
  And I click "Edit" in the "Content Head" region
  Then I fill in "edit-title" with "Bar"
  And I press the "Save" button
  Then I should see "News Item Bar has been updated" in the "Console" region
  And I should be on "news/bar"
  And I am on "news/bar"
  And I click "Edit" in the "Content Head" region
  And I click on the element with css selector "#edit-delete"
  And I click on the element with css selector "#edit-submit"
  Then I should see the text "News Item Bar has been deleted" in the "Console" region

  @api @dev @destructive @javascript
  Scenario: Ensure editors can edit but not delete news items that aren't theirs
  Given I am logged in as a user with the "site owner" role
  When I wait for the Site Actions drop down to appear
  And I click "Add News Item" in the "Admin Shortcuts" region
  Then I should see "Create News Item" in the "Branding" region
  And the "Text format" field should contain "content_editor_text_format"
  Then I fill in "edit-title" with "Foo"
  And I press the "Save" button
  Then I should see "News Item Foo has been created" in the "Console" region
  And I should be on "news/foo"
  Given I am logged in as a user with the "editor" role
  And I am on "news/foo"
  And I click "Edit" in the "Content Head" region
  Then I fill in "edit-title" with "Bar"
  And I press the "Save" button
  Then I should see "News Item Bar has been updated" in the "Console" region
  And I should be on "news/bar"
  When I click "Edit" in the "Content Head" region
  Then I should not see an "#edit-delete" element
  Given I am logged in as a user with the "site owner" role
  And I am on "news/bar"
  And I click "Edit" in the "Content Head" region
  And I click on the element with css selector "#edit-delete"
  And I click on the element with css selector "#edit-submit"
  Then I should see the text "News Item Bar has been deleted" in the "Console" region

  @api @dev @destructive @javascript
  Scenario: Ensure editors can create, edit and delete their own news items
  Given I am logged in as a user with the "editor" role
  When I wait for the Site Actions drop down to appear
  And I click "Add News Item" in the "Admin Shortcuts" region
  Then I should see "Create News Item" in the "Branding" region
  And the "Text format" field should contain "content_editor_text_format"
  Then I fill in "edit-title" with "Foo"
  And I press the "Save" button
  Then I should see "News Item Foo has been created" in the "Console" region
  And I should be on "news/foo"
  And I click "Edit" in the "Content Head" region
  Then I fill in "edit-title" with "Bar"
  And I press the "Save" button
  Then I should see "News Item Bar has been updated" in the "Console" region
  And I should be on "news/bar"
  And I click "Edit" in the "Content Head" region
  And I click on the element with css selector "#edit-delete"
  And I click on the element with css selector "#edit-submit"
  Then I should see the text "News Item Bar has been deleted" in the "Console" region

  @api @dev @destructive @javascript
  Scenario: Ensure site owners can edit and delete news items that aren't theirs
  Given I am logged in as a user with the "editor" role
  When I wait for the Site Actions drop down to appear
  And I click "Add News Item" in the "Admin Shortcuts" region
  Then I should see "Create News Item" in the "Branding" region
  And the "Text format" field should contain "content_editor_text_format"
  Then I fill in "edit-title" with "Foo"
  And I press the "Save" button
  Then I should see "News Item Foo has been created" in the "Console" region
  And I should be on "news/foo"
  Given I am logged in as a user with the "site owner" role
  And I am on "news/foo"
  And I click "Edit" in the "Content Head" region
  Then I fill in "edit-title" with "Bar"
  And I press the "Save" button
  Then I should see "News Item Bar has been updated" in the "Console" region
  And I should be on "news/bar"
  And I am on "news/bar"
  And I click "Edit" in the "Content Head" region
  And I click on the element with css selector "#edit-delete"
  And I click on the element with css selector "#edit-submit"
  Then I should see the text "News Item Bar has been deleted" in the "Console" region
