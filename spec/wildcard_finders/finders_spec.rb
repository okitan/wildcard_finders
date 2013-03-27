require "spec_helper"

describe WildcardFinders::Finders do
  include WildcardFinders::Finders

  it "find_anchor_like works with hash" do
    visit "/a"

    page.find_anchor_like(href: /hoge/)[:id].should == "href_hoge"
    page.find_anchor_like(href: /fuga/)[:id].should == "href_fuga"

    page.find_anchor_like(onclick: /hoge/)[:id].should == "onclick_hoge"
  end
end
