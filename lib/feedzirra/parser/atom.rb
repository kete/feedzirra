module Feedzirra
  
  module Parser
    # == Summary
    # Parser for dealing with Atom feeds.
    #
    # == Attributes
    # * prev_page
    # * next_page
    # * lat_page
    # * title
    # * subtitle
    # * updated
    # * feed_url
    # * url
    # * related
    # * entries
    class Atom
      include SAXMachine
      include FeedUtilities
      element :"atom:link", :as => :prev_page, :value => :href, :with => {:rel => 'prev'}
      element :"atom:link", :as => :next_page, :value => :href, :with => {:rel => 'next'}
      element :"atom:link", :as => :last_page, :value => :href, :with => {:rel => 'last'}
      element :title
      element :subtitle
      element :updated
      element :link, :as => :url, :value => :href, :with => {:type => "text/html"}
      element :link, :as => :feed_url, :value => :href, :with => {:type => "application/atom+xml"}
      elements :link, :as => :related, :value => :href, :with => {:rel => "related"}
      elements :link, :as => :links, :value => :href
      elements :entry, :as => :entries, :class => AtomEntry

      def self.able_to_parse?(xml) #:nodoc:
        xml =~ /(Atom)|(#{Regexp.escape("http://purl.org/atom")})/
      end
      
      def url
        @url || links.last
      end
      
      def feed_url
        @feed_url || links.first
      end
    end
  end
  
end