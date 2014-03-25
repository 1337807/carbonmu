require 'spec_helper'

class TestPersisted
  include Persistable

  field :foo
  read_only_field :read_only_foo
end

describe Persistable do
  context "regular fields" do
    it "supports registering fields as persisted" do
      TestPersisted.fields.should include(:foo)
    end

    it "defines an accessor for fields" do
      tester = TestPersisted.new
      tester.should respond_to(:foo)
      tester.should respond_to(:foo=)
    end

    it "doesn't let you directly edit klass.fields" do
      TestPersisted.should_not respond_to(:fields=)
    end
  end

  context "read-only fields" do
    it "supports registering read-only fields as persisted" do
      TestPersisted.fields.should include(:read_only_foo)
    end

    it "supports read-only fields" do
      tester = TestPersisted.new
      tester.should respond_to(:read_only_foo)
      tester.should_not respond_to(:read_only_foo=)
    end
  end

  it "defines a _id field that's read-only" do
    tester = TestPersisted.new
    tester.should respond_to(:_id)
    tester.should_not respond_to(:_id=)
  end

  it "generates _id uniquely" do
    tester = TestPersisted.new
    other_tester = TestPersisted.new
    tester._id.should_not eq(other_tester._id)
  end
end