require File.dirname(__FILE__) + '/../spec_helper'

describe Feedzirra::RSS do
  describe "#will_parse?" do
    it "should return true for an RSS feed" do
      Feedzirra::RSS.should be_able_to_parse(sample_rss_feed)
    end

    # this is no longer true. combined rdf and rss into one
    # it "should return false for an rdf feed" do
    #   Feedzirra::RSS.should_not be_able_to_parse(sample_rdf_feed)
    # end
    
    it "should return fase for an atom feed" do
      Feedzirra::RSS.should_not be_able_to_parse(sample_atom_feed)
    end
  end

  describe "parsing of simple rss feed" do
    before(:each) do
      @feed = Feedzirra::RSS.parse(sample_rss_feed)
    end
    
    it "should parse the title" do
      @feed.title.should == "Tender Lovemaking"
    end
    
    it "should parse the url" do
      @feed.url.should == "http://tenderlovemaking.com"
    end
    
    it "should provide an accessor for the feed_url" do
      @feed.respond_to?(:feed_url).should == true
      @feed.respond_to?(:feed_url=).should == true
    end
    
    it "should parse entries" do
      @feed.entries.size.should == 10
    end
  end

  describe "parsing of media rss feed" do
    before(:each) do
      @feed = Feedzirra::RSS.parse(sample_media_rss_feed)
    end

    it "should parse the title" do
      @feed.title.should == "horowhenua.kete.net.nz - Latest 50 Results in images"
    end

    it "should parse the url" do
      @feed.url.should == "http://horowhenua.kete.net.nz/site/all/images/rss.xml?search_terms=wellington"
    end

    it "should parse link rel='related' as related" do
      @feed.related.should == ["http://horowhenua.kete.net.nz/", "http://horowhenua.kete.net.nz/site/all/images"]
    end

    it "should parse the description" do
      @feed.description.should == "Showing 1 - 50 results of 368"
    end

    it "should parse the language" do
      @feed.language.should == "en-nz"
    end

    it "should provide an accessor for the feed_url" do
      @feed.respond_to?(:feed_url).should == true
      @feed.respond_to?(:feed_url=).should == true
    end

    it "should parse entries" do
      @feed.entries.size.should == 50
    end
  end

end