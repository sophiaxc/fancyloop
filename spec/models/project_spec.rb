# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Project do

  let(:user) { FactoryGirl.create(:user) }
  before { @project = user.projects.build(title: "Lorem ipsum") }

  subject { @project }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:revisions) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @project.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Project.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "with blank title" do
    before { @project.title = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @project.title = "a" * 141 }
    it { should_not be_valid }
  end

  describe "revisions associations" do

    before { @project.save }
    let!(:older_revision) do 
      FactoryGirl.create(:revision, project: @project, created_at: 1.day.ago)
    end
    let!(:newer_revision) do
      FactoryGirl.create(:revision, project: @project, created_at: 1.hour.ago)
    end

    it "should have the right revisions in the right order" do
      @project.revisions.should == [newer_revision, older_revision]
    end

    it "should destroy associated revisions" do
      revisions = @project.revisions
      @project.destroy
      revisions.each do |revision|
        Revision.find_by_id(revision.id).should be_nil
      end
    end
  end
end
