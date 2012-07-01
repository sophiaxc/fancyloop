# == Schema Information
#
# Table name: revisions
#
#  id                 :integer         not null, primary key
#  project_id         :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  caption            :string(255)
#

require 'spec_helper'

describe Revision do

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { user.projects.create!(title: "Lorem ipsum") }
  before do
    image = File.open('./app/assets/images/sample_data/sample_image.png')
    @revision = project.revisions.build(image: image)
  end

  subject { @revision }

  it { should respond_to(:project_id) }
  it { should respond_to(:image) }
  it { should respond_to(:feedbacks) }
  it { should respond_to(:project) }
  its(:project) { should == project }

  it { should be_valid }

  describe "when project id is not present" do
    before { @revision.project_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to project_id" do
      expect do
        Revision.new(project_id: project.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
