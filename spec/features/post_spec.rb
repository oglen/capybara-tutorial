require 'rails_helper'

posts = [
    {
        'title' => 'my first post',
        'content' => 'I wanna be the full-stack dev'
    }, {
        'title' => 'hello world',
        'content' => 'I wanna be a good dev'
    }
]

RSpec.feature 'post feature', type: :feature do

  scenario 'create new post' do
    visit '/posts'
    on_page_with :post_list do |page|
      expect(page.posts_in_list.length).to eq(0)

      posts.each_with_index do |_, i|
        page.new_post_link.click
        page.perform :fill_post, posts[i]['title'], posts[i]['content']
        page.create_post_button.click
        expect(page.notice_message).to eq('Post was successfully created.')
        expect(page.notice_title).to eq(posts[i]['title'])
        expect(page.notice_content).to eq(posts[i]['content'])
        page.back_link.click
      end

      page.titles_in_list.each_with_index { |title, i| expect(title.text).to eq(posts[i]['title']) }
      page.contents_in_list.each_with_index { |content, i| expect(content.text).to eq(posts[i]['content']) }

    end
  end
end