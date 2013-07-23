require "spec_helper"

describe WildcardFinders::Matchers do
  include WildcardFinders::Matchers

  context ".has_anchor_like?" do
    it "returns true when there is an anchor" do
      visit "/a"
      page.has_anchor_like?(href: /hoge/).should be_true
    end

    it "returns true when ther are no anchors" do
      visit "/a"
      page.has_anchor_like?(href: /not_exist/).should be_false
    end
  end

  context ".has_no_anchor_like?" do
    it "returns true when there is an anchor" do
      visit "/a"
      page.has_no_anchor_like?(href: /hoge/).should be_false
    end

    it "returns true when ther are no anchors" do
      visit "/a"
      page.has_no_anchor_like?(href: /not_exist/).should be_true
    end
  end
end
