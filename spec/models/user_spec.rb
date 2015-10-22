require 'rails_helper'

describe User do

  it {is_expected.to have_many :posts}
  it {is_expected.to have_many :comments}
  it {is_expected.to have_many :liked_posts}

end
