module Feedzirra
  # == Summary
  # Parser for dealing with RSS feeds.
  #
  # == Attributes
  # * prev_page
  # * next_page
  # * last_page
  # * title
  # * feed_url
  # * url
  # * related
  # * description
  # * language
  # * entries
  class RSS
    include SAXMachine
    include FeedUtilities
    element :"atom:link", :as => :prev_page, :value => :href, :with => {:rel => 'prev'}
    element :"atom:link", :as => :next_page, :value => :href, :with => {:rel => 'next'}
    element :"atom:link", :as => :last_page, :value => :href, :with => {:rel => 'last'}
    element :title
    element :link, :as => :url
    elements :link, :as => :related, :value => :href, :with => {:rel => "related"}
    element :description
    element :language

    elements :item, :as => :entries, :class => RSSEntry

    attr_accessor :feed_url

    def self.able_to_parse?(xml) #:nodoc:
      xml =~ /\<rss|rdf/
    end
  end
end