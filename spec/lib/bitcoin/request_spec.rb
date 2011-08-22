require 'spec_helper'

describe Bitcoin::Request do
  it "should omit null arguments and everything after them" do
    # bitcoin rejects null values even for optional params. Since
    # even params following those may have default non-nil values,
    # we'll assume the first non-nil value marks a set of optional
    # params, and drop it and everything following it.

    req = Bitcoin::Request.new('svc', [1, nil, nil, nil])
    req.params.should == [1]
    
    req = Bitcoin::Request.new('svc', [nil])
    req.params.should == []
    
    req = Bitcoin::Request.new('svc', [1, nil, nil, 1, nil])
    req.params.should == [1]
  end
end
