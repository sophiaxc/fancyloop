# == Schema Information
#
# Table name: feedbacks
#
#  id          :integer         not null, primary key
#  comment     :string(255)
#  author      :string(255)
#  user_id     :integer
#  revision_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Feedback do

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { user.projects.create!(title: "Lorem ipsum") }
  image = File.open('./app/assets/images/sample_data/sample_image.png')
  let(:revision) { project.revisions.create!(image: image) }
  before do
    @feedback = revision.feedbacks.build(comment: "Sick design")
  end

  subject { @feedback }

  it { should respond_to(:revision_id) }
  it { should respond_to(:comment) }
  it { should respond_to(:author) }
  it { should respond_to(:user_id) }
  it { should respond_to(:revision) }
  its(:revision) { should == revision }

  it { should be_valid }

  describe "when revision id is not present" do
    before { @feedback.revision_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to revision_id" do
      expect do
        Feedback.new(revision: revision.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
