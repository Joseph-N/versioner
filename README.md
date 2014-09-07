# PROOF OF CONCEPT APP README

Versioner, a generic name I gave this project is a simple rails project that versions articles and their related files.
Articles belong to an organisation and so are users. The application users `postgresql` as it's database. You will have
to make sure you have that installed then change the credentials in `config/database.yml` to match yours.

For now, organisations are created through a seed file in `db/seeds.rb` file to simply the process of creating them though
you could still create one from the interface. To create the dummy organisations run

```
rake db:seed
```

## Model relationships

1. Organisation Model
..* has_many :users
..* has_many :articles

2. User Model
..* belongs_to :organisation
..* has_many :articles, through: :organisation

3. Article Model
⋅⋅* belongs_to :user
..* belongs_to :organisation
..* has_many :attachments
..* has_many :attachment_trackers

4. AttachmentTracker Model
..* belongs_to :article


The app uses [devise gem](https://github.com/plataformatec/devise) to handle authentication, both signup and signin.
On registration, a user is automatically assigned to an organisation (for now) so that he/she belongs to an organisation

```ruby
class User < ActiveRecord::Base
  # validations etc 

  # assign a user to a random organisation
  before_save :assign_organisation

  private

  def assign_organisation
    self.organisation_id = Organisation.all.map(&:id).sample
  end
end
```

A user is then able to create an article which belongs to that organisation thereafter.

To handle versioning, i've used the [vestal_versions gems](https://github.com/laserlemon/vestal_versions).

> I've cloned this repository and updated it to work on rails 4 as those pull requests on the original repository
> have not yet been merged to master and therefore it's breaking in rails 4. You'll notice in my Gemfile i'm pulling this
> gem from my forked repo

The versioned models are

1. Article
2. Attachments

The vestal versions gem will automatically set up the `has_many` revisions to each of the above model.

## How it works

After you log in, you'll see a `new article` button on the navigation bar. Clicking on it will take you to a form to create a new article. Fill in the required fields an also you can attach as many files as you would want before creating the article.

This is set up by this directive in the article model
 `accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |a| a[:image].blank? }`

The reason I din't use the jQuery upload plugin in my blog post is because it uploads automatically on selecting the file. It would work if we were to create the attachments separately after we create an article.

After creating the article, you'll be redirected to the article and you'll see the uploaded attachments. To create a new version, just hit the edit button and change any attribute you wish and also the attachments you would want to keep by checking the `keep` checkbox present on the edit form.

On submit, we'll save the id's of the checked attachments to the article's attachment_tracker model so that we keep track
of the attachments that belonged to an article at a particular version.

Attachments can also be edited by clicking on the attachment thumbnail, hitting edit button and then uploading a new
version (image) and that will automatically create a new version for it.

## conclusion

That should be it! I'm hoping I din't leave anything out from the requirements. Please feel free to reach me regarding any questions on this either by email or on oDesk message. I will be more than glad to clarify any functionality/ issue


### Thank you so much!