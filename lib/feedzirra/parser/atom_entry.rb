module Feedzirra
  
  module Parser
    # == Summary
    # Parser for dealing with Atom feed entries.
    #
    # == Attributes
    # * title
    # * url
    # * related
    # * author
    # * content
    # * summary
    # * published
    # * categories
    # * media_content
    # * media_description
    # * media_thumbnail
    # * enclosure
    class AtomEntry
      include SAXMachine
      include FeedEntryUtilities
      element :title
      element :link, :as => :url, :value => :href, :with => {:rel => "alternate"}
      elements :link, :as => :related, :value => :href, :with => {:rel => "related"}
      element :name, :as => :author
      element :content
      element :summary
      element :published
      element :id
      element :created, :as => :published
      element :issued, :as => :published
      element :updated
      element :modified, :as => :updated
      elements :category, :as => :categories, :value => :term

      element :"media:content", :as => :media_content, :value => :url
      element :"media:description", :as => :media_description
      element :"media:thumbnail", :as => :media_thumbnail, :value => :url
      element :enclosure, :value => :url

      elements :link, :as => :links, :value => :href

      def url
        @url || links.first
      end
    end

  end
  
end