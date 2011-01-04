xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom"){
  xml.channel{
    xml.title("Recommendations")
    xml.link("http://localhost.recommendations/")
    xml.description("Lots of recommendations to follow (or not).")
    xml.language('en-gb')
      for recommendation in @recommendations
        xml.item do

          xml.title recommendation.name
          if recommendation.description
            xml.description  description_format(recommendation.description.description)
          else 
            xml.description ""
          end
          xml.pubDate(recommendation.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          xml.link(url_for(:action => "show", :id => recommendation.id, :only_path => false))
          xml.guid(url_for(:action => "show", :id => recommendation.id, :only_path => false))
        end
      end
  }
}
