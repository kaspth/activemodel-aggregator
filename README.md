# Activemodel::Aggregator

Based on https://gist.github.com/dhh/b0a106a00e8737280666

This is currently a thought spill and not necessarily true. At the very least I wouldn't use it in production.

## Context aware validations

Every aggregator has its own validation context, such that:

```ruby
class Profile < ActiveModel::Aggregator
  aggregate :person
end

class Person < ActiveRecord::Base
  validates_presence_of :name, on: :profile
end
```

...would only validate the name when submitted through the profile.

## Routing to an aggregator

Since an aggregator handles several models and is not itself persisted there's
no way to route to it directly.

The best way is to use one of the aggregated models.

```ruby
resources :people do
  resource :profile, only: :show
end

# Generates
GET  /people/:person_id/profile(.:format)  profiles#show

# Then in your controller
class ProfilesController < ApplicationController
  before_action :set_person

  def show
    @profile = Profile.new(person: @person)
  end
  
  private
    def set_person
      @person = Person.find(params[:person_id])
    end
end 
```

You could also accept users by an invite email.

```ruby
class InvitesController < ApplicationController
  before_action :set_email

  def new
    @profile = Profile.new(email: @email)
  end

  private
    def set_email
      @email = Email.find(params[:email_id])
    end
end
```