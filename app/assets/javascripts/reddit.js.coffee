$ ->
  $('.search').on('keyup', '#reddit_form_search', (e) ->
    $search = $(@)
    if $search.val()
      $('#reddit_website').attr('href', "http://www.reddit.com/search?q=#{encodeURI($search.val())}")
    else
      console.log("http://www.reddit.com/")
    false
  )