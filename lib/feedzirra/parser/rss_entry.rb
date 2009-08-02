module Feedzirra
  
  module Parser
    # == Summary
    # Parser for dealing with RDF feed entries.
    #
    # == Attributes
    # * title
    # * url
    # * related
    # * author
    # * content
    # * summary
    # * published
    # * updated
    # * categories
    # * media_content
    # * media_description
    # * media_thumbnail
    # * enclosure
    class RSSEntry
      include SAXMachine
      include FeedEntryUtilities
      element :title
      element :link, :as => :url
      elements :link, :as => :related, :value => :href, :with => {:rel => "related"}

      element :author
      element :"dc:creator", :as => :author
      element :author, :as => :author
      element :"content:encoded", :as => :content
      element :description, :as => :summary

      element :pubDate, :as => :published
      element :pubdate, :as => :published
      element :"dc:date", :as => :published
      element :"dc:Date", :as => :published
      element :"dcterms:created", :as => :published


      element :"dcterms:modified", :as => :updated
      element :issued, :as => :published
      elements :category, :as => :categories

      element :"media:content", :as => :media_content, :value => :url
      element :"media:description", :as => :media_description
      element :"media:thumbnail", :as => :media_thumbnail, :value => :url
      element :enclosure, :value => :url

      element :guid, :as => :id
    end

  end
  
end