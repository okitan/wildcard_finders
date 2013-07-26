require "spec_helper"

describe WildcardFinders::Matchers do
  include WildcardFinders::Matchers

  context ".has_anchor_like?" do
    it "returns true when there is an anchor" do
      visit "/a"
      page.has_anchor_like?(href: /hoge/).should be_true
      page.should have_anchor_like(href: /hoge/)

      page.has_anchor_like? {|a| /hoge/ === a[:href] }.should be_true
      page.should have_anchor_like {|a| /hoge/ === a[:href] }
    end

    it "returns true when ther are no anchors" do
      visit "/a"
      page.has_anchor_like?(href: /not_exist/).should be_false
      page.should_not have_anchor_like(href: /not_exist/)

      page.has_anchor_like? {|a| /not_exist/ === a[:href] }.should be_false
      page.should_not have_anchor_like {|a| /not_exist/ === a[:href] }
    end
  end

  context ".has_no_anchor_like?" do
    it "returns true when there is an anchor" do
      visit "/a"
      page.has_no_anchor_like?(href: /hoge/).should be_false
      page.should_not have_no_anchor_like(href: /hoge/)

      page.has_no_anchor_like? {|a| /hoge/ === a[:href] }.should be_false
      page.should_not have_no_anchor_like {|a| /hoge/ === a[:href] }
    end

    it "returns true when ther are no anchors" do
      visit "/a"
      page.has_no_anchor_like?(href: /not_exist/).should be_true
      page.should have_no_anchor_like(href: /not_exist/)

      page.has_no_anchor_like? {|a| /not_exist/ === a[:href] }.should be_true
      page.should have_no_anchor_like {|a| /not_exist/ === a[:href] }
    end
  end
end
