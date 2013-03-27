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
      it do
        example.description.replace("with hash #{attr} => #{value.inspect} matches")

        visit "/a"
        page.find_anchor_like(attr => value)[:id].should == expected_id
      end
    end
  end
end
