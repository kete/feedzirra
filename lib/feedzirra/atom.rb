module Feedzirra
  # == Summary
  # Parser for dealing with Atom feeds.
  #
  # == Attributes
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
    element :title
    element :subtitle
    element :updated
    element :link, :as => :url, :value => :href, :with => {:type => "text/html"}
    element :link, :as => :feed_url, :value => :href, :with => {:type => "application/atom+xml"}
    elements :link, :as => :related, :value => :href, :with => {:rel => "related"}

    elements :entry, :as => :entries, :class => AtomEntry

    def self.able_to_parse?(xml) #:nodoc:
      xml =~ /(Atom)|(#{Regexp.escape("http://purl.org/atom")})/
    end
  end
end