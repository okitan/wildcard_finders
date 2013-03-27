require "spec_helper"

describe WildcardFinders::Finders do
  include WildcardFinders::Finders

  context ".find_anchor_like" do
    where(:attr, :value, :expected_id) do
      [ [ :href,    /hoge/, "href_hoge" ],
        [ :href,    /fuga/, "href_fuga" ],
        [ :onclick, /hoge/, "onclick_hoge" ],
      ]
    end

    with_them do
      it "with hash as matcher ({ attr => value }) finds" do
        visit "/a"
        page.find_anchor_like(attr => value)[:id].should == expected_id
      end

      it "with block as matcher ({|e| value === e[attr] }) finds" do
        visit "/a"
        page.find_anchor_like {|e| value === e[attr] }[:id].should == expected_id
      end

      it "with proc as matcher (->(e) { value === e[attr] }) finds" do
        visit "/a"
        page.find_anchor_like(->(e) { value === e[attr] })[:id].should == expected_id
      end
    end
  end
end
