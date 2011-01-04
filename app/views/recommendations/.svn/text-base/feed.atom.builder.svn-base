atom_feed({'xmlns:app' => 'http://www.w3.org/2007/app',
    'xmlns:openSearch' => 'http://a9.com/-/spec/opensearch/1.1/'}) do |feed|
  feed.title("Recommendations")
  feed.updated((@recommendations.first.created_at))
  
  for recommendation in @recommendations
    feed.entry(recommendation) do |entry|
      entry.title(recommendation.name)
      if recommendation.description
        entry.content(description_format(recommendation.description.description), :type => 'html') 
      else
        entry.content "", :type => 'html'
      end
      entry.author do |author|
        author.name recommendation.user.username
      end  
    end
  end
end
