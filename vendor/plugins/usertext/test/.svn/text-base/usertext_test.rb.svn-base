require 'test_helper'
require File.dirname(__FILE__) + "/../lib/usertext"

class UsertextTest < Test::Unit::TestCase
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper
  include UserTextHelper
  include ApplicationHelper


  def test_paragraph_insertion
    assert_equal("<p>Hello!</p>", usertext("Hello!"))
  end

  def test_two_paragraphs_insertion
    assert_equal("<p>Hello!</p>\n\n<p>Wow!</p>", usertext("Hello!\n\nWow!"))
  end
  
  def test_three_paragraph_insertion
    assert_equal("<p>Hello!</p>\n\n<p>Wow!</p>\n\n<p>Woop!</p>", 
      usertext("Hello!\n\nWow!\n\nWoop!"))
  end
  
  def test_four_paragraph_insertion
    assert_equal("<p>Hello!</p>\n\n<p>Wow!</p>\n\n<p>Woop!</p>\n\n<p>Pow!</p>", 
      usertext("Hello!\n\nWow!\n\nWoop!\n\nPow!"))
  end

  def test_elipsis_insertion
    assert_equal "<p>I eat… worms!</p>", usertext("I eat... worms!")
  end

  def test_elipsis_insertion_at_end_of_string
    assert_equal "<p>I want to…</p>", usertext("I want to...")
  end
  
  def test_insert_typographic_apostrophe
    assert_equal "<p>Jamie’s house</p>", usertext("Jamie's house")
  end
  
  def test_insert_typographic_apostrophe_in_decade_reference
    assert_equal "<p>It was acceptable in the ’80s.</p>", usertext("It was acceptable in the '80s.")
  end
  
  def test_insert_typographic_double_quotes
    assert_equal "<p>She said “hello”.</p>", usertext("She said \"hello\".")
  end
  
  def test_insert_typographic_single_quotes
    assert_equal "<p>She said ‘hello’.</p>", usertext("She said 'hello'.")
  end  
  
  def test_insert_multiplication_character
    assert_equal "<p>2×2=4</p>", usertext("2x2=4")
  end
  
  def test_insert_figure_dash
    assert_equal "<p>Telephone 867‒5309.</p>", usertext("Telephone 867-5309.")
  end
  
  def test_insert_en_dash
    assert_equal "<p>For ages 3–5.</p>", usertext("For ages 3-5.")
  end
  
  def test_insert_em_dash
    assert_equal "<p>I am not sure—although I really should be—what to do.</p>", usertext("I am not sure--although I really should be--what to do.")
  end
  


  def test_insert_degrees_symbol
    assert_equal "<p>It is 20℃.</p>", usertext("It is 20 degrees c.")
    assert_equal "<p>It is 20℉.</p>", usertext("It is 20 degrees f.")
  end

  def test_insert_pound_symbol
    assert_equal "<p>That costs £30.</p>", usertext("That costs GBP30.")    
  end

  def test_insert_dollar_symbol
    assert_equal "<p>That costs $30.</p>", usertext("That costs USD30.")
    assert_equal "<p>That costs $30.</p>", usertext("That costs US30.")
    assert_equal "<p>Item code PTSTUSD7201.</p>", usertext("Item code PTSTUSD7201.")
  end
  
  def test_insert_euro_symbol
    assert_equal "<p>That costs €30.</p>", usertext("That costs EUR30.")
  end

  def test_insert_yen_symbol
    assert_equal "<p>That costs ¥30.</p>", usertext("That costs YEN30.")
  end
  
  def test_insert_sheqel_sign_symbol
    assert_equal "<p>That costs ₪30.</p>", usertext("That costs ILS30.")
  end
  
  
  def test_insert_copyright_symbol
    assert_equal "<p>©Frankie Roberto</p>", usertext("(c)Frankie Roberto")
    assert_equal "<p>© Frankie Roberto</p>", usertext("(c) Frankie Roberto")
    assert_equal "<p>This text is in ©</p>", usertext("This text is in (c)")
  end

  
  def test_insert_suspended_hyphen
    assert_equal "<p>nineteenth‐ and twentieth‐century writers</p>", usertext("nineteenth- and twentieth-century writers")
  end
  
  def test_insert_hyphen
    assert_equal "<p>This is a real‐world example.</p>", usertext("This is a real-world example.")
  end  
  
  def test_auto_link_phone_numbers
    assert_equal "Phone me on <a href=\"tel:+447736111111\">+447736111111</a>", auto_link_phone_numbers("Phone me on +447736111111")
    assert_equal "Phone me on <a href=\"tel:+447736111111\">+447736111111</a>.", auto_link_phone_numbers("Phone me on +447736111111.")
    assert_equal "Phone me on <a href=\"tel:07736111111\">07736111111</a>", auto_link_phone_numbers("Phone me on 07736111111")
    assert_equal "Phone me on <a href=\"tel:07736111111\">07736111111</a>.", auto_link_phone_numbers("Phone me on 07736111111.")
  end
  
  def test_insert_numero_character
    assert_equal "<p>I live at № 4 Privet Drive</p>", usertext("I live at No. 4 Privet Drive")
    assert_equal "<p>Tell me your №</p>", usertext("Tell me your No.")
    assert_equal "<p>№ 3 is the winner!</p>", usertext("No. 3 is the winner!")
  end

  def test_care_of_character
    assert_equal "<p>Send it to me ℅ my company.</p>", usertext("Send it to me c/o my company.")
  end

  
  def test_code_tag
    assert_equal "<p>Don’t use the <code>&lt;blink&gt;</code> tag.</p>", usertext("Don't use the <blink> tag.")
    assert_equal "<p>4 &lt; 7 &gt; 1</p>", usertext("4 < 7 > 1")
  end
  
  def test_block_of_code
    assert_equal "<p>Use this code:</p>\n\n<div><code>&lt;html&gt;</code></div>",
    usertext("Use this code:\n\n<html>")
  end
  
  def test_mark_list
    assert_equal "<ul>\n<li>Milk</li>\n<li>Eggs</li>\n<li>Flour</li>\n</ul>", usertext("* Milk\n* Eggs\n* Flour")
  end
  
  def test_mark_lists
    assert_equal "<p>List:</p>\n\n<ul>\n<li>apples</li>\n<li>pears</li>\n</ul>\n\n<p>And forget milk!</p>", usertext("List:\n\n* apples\n* pears\n\nAnd forget milk!")
  end

  def test_mark_lists_2
    assert_equal "<p>List:</p>\n\n<ul>\n<li>apples</li>\n<li>pears</li>\n</ul>", usertext("List:\n\n* apples\n* pears")
  end
  
  def test_mark_ordered_list
    assert_equal "<p>Method:</p>\n\n<ol>\n<li>Stir</li>\n<li>Bake</li>\n<li>Lick spoon</li>\n</ol>", usertext("Method:\n\n1. Stir\n2. Bake\n3. Lick spoon")
    assert_equal "<p>Method:</p>\n\n<ol>\n<li>Stir</li>\n<li>Bake</li>\n<li>Lick spoon</li>\n</ol>", usertext("Method:\n\n1) Stir\n2) Bake\n3) Lick spoon")
  end
  
  def test_nothing
    assert_equal("", usertext(""))
  end

  def test_auto_link_ftp_url
    assert_equal "<p><a href=\"ftp://test.com\">test.com</a></p>", usertext("ftp://test.com")
  end
  
  def test_auto_link_url
    assert_equal "<p><a href=\"http://test.com\">test.com</a></p>", usertext("http://test.com")
  end

  def test_auto_link_truncated_url
    assert_equal "<p><a href=\"http://thisisareallyreallyreallyreallyreallylongurl.com\">thisisareallyreall...yreallylongurl.com</a></p>", usertext("http://thisisareallyreallyreallyreallyreallylongurl.com")
  end
  
  def test_one_quarter_symbol
    assert_equal "<p>I have ¼ hour left.</p>",
    usertext("I have 1/4 hour left.")
  end

  def test_one_half_symbol
    assert_equal "<p>I have ½ hour left.</p>",
    usertext("I have 1/2 hour left.")
  end
  
  def test_threw_quarters_symbol
    assert_equal "<p>I have ¾ hour left.</p>", usertext("I have 3/4 hour left.")
    assert_equal "<p>Give me ¾</p>", usertext("Give me 3/4")
    assert_equal "<p>I am on 123/4567.</p>", usertext("I am on 123/4567.")
  end  
  
  def test_insert_registered_trademark_symbol
    assert_equal "<p>I like LegoⓇ.</p>", usertext("I like Lego(R).")
    assert_equal "<p>I like LegoⓇ</p>", usertext("I like Lego(R)")
    assert_equal "<p>I like LegoⓇ bricks.</p>", usertext("I like Lego(R) bricks.")
    assert_equal "<p>x = 2(R)n</p>", usertext("x = 2(R)n")
  end

  
  def test_blockquote
    assert_equal "<p>She said:</p>\n\n<blockquote><p>I love you.</p></blockquote>", usertext("She said:\n\n\"I love you.\"")
  end


  def test_insert_roman_numerals
    assert_equal "<p>The year Ⅱ.</p>", usertext("The year II.")
    assert_equal "<p>Ⅱ green bottles.</p>", usertext("II green bottles.")
    assert_equal "<p>The year Ⅲ.</p>", usertext("The year III.")
    assert_equal "<p>Ⅲ green bottles.</p>", usertext("III green bottles.")
    assert_equal "<p>The year Ⅳ.</p>", usertext("The year IV.")
    assert_equal "<p>Ⅳ green bottles.</p>", usertext("IV green bottles.")
    assert_equal "<p>The year Ⅴ.</p>", usertext("The year V.")
    assert_equal "<p>Ⅴ green bottles.</p>", usertext("V green bottles.")
    assert_equal "<p>The year Ⅵ.</p>", usertext("The year VI.")
    assert_equal "<p>Ⅵ green bottles.</p>", usertext("VI green bottles.")
    assert_equal "<p>The year Ⅶ.</p>", usertext("The year VII.")
    assert_equal "<p>Ⅶ green bottles.</p>", usertext("VII green bottles.")
    assert_equal "<p>The year Ⅷ.</p>", usertext("The year VIII.")
    assert_equal "<p>Ⅷ green bottles.</p>", usertext("VIII green bottles.")
    assert_equal "<p>The year Ⅸ.</p>", usertext("The year IX.")
    assert_equal "<p>Ⅸ green bottles.</p>", usertext("IX green bottles.")
    assert_equal "<p>The year Ⅹ.</p>", usertext("The year X.")
    assert_equal "<p>Ⅹ green bottles.</p>", usertext("X green bottles.")
  end

  def test_insert_smiley_characters
    assert_equal "<p>Yay! ☺</p>", usertext("Yay! :-)")
    assert_equal "<p>Yay! ☺</p>", usertext("Yay! :)")    
    assert_equal "<p>No! ☹</p>", usertext("No! :-(")
    assert_equal "<p>No! ☹</p>", usertext("No! :(")    
  end


end
