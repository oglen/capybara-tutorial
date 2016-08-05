require 'rails_helper'

sleepSeconds = 0

RSpec.feature 'post feature', type: :feature do
  scenario 'create new post' do
    visit '/posts'
    sleep(sleepSeconds)

    click_link('New Post')
    fill_in('post_title', with: 'my first post')
    sleep(sleepSeconds)
    fill_in('post_content', with: 'I wanna be the full-stack dev')
    sleep(sleepSeconds)
    click_button('Create Post')
    sleep(sleepSeconds)
    expect(page).to have_content('Title: my first post')
    expect(page).to have_content('Content: I wanna be the full-stack dev')
    sleep(sleepSeconds)
    click_link('Back')

    sleep(sleepSeconds)

    click_link('New Post')
    fill_in('post_title', with: 'my second post')
    sleep(sleepSeconds)
    fill_in('post_content', with: 'Scala is the best programing language in the world.')
    sleep(sleepSeconds)
    click_button('Create Post')
    sleep(sleepSeconds)
    expect(page).to have_content('Title: my second post')
    expect(page).to have_content('Content: Scala is the best programing language in the world.')
    sleep(sleepSeconds)
    click_link('Back')

    sleep(sleepSeconds)

    click_link('Edit', match: :first)
    sleep(sleepSeconds)
    fill_in('post_title', with: 'my first post edited')
    sleep(sleepSeconds)
    fill_in('post_content', with: 'I wanna be a scala dev')
    sleep(sleepSeconds)
    click_button('Update Post')
    sleep(sleepSeconds)
    expect(page).to have_content('Title: my first post edited')
    expect(page).to have_content('Content: I wanna be a scala dev')
    click_link('Back')

    sleep(sleepSeconds)

    all('a', :text => 'Edit')[1].click
    fill_in('post_title', with: 'my second post edited')
    sleep(sleepSeconds)
    fill_in('post_content', with: 'Scala is the best programing language in the universe.')
    sleep(sleepSeconds)
    click_button('Update Post')
    sleep(sleepSeconds)
    expect(page).to have_content('Title: my second post edited')
    expect(page).to have_content('Content: Scala is the best programing language in the universe.')

    sleep(sleepSeconds)

    visit '/posts'
    sleep(sleepSeconds)
    expect(page).to have_content('my first post edited')
    expect(page).to have_content('I wanna be a scala dev')
    expect(page).to have_content('my second post edited')
    expect(page).to have_content('Scala is the best programing language in the universe.')
    sleep(sleepSeconds)

    click_link('Destroy', match: :first)
    sleep(sleepSeconds)
    page.driver.browser.switch_to.alert.accept
    sleep(sleepSeconds)
    expect(page).to have_content('Post was successfully destroyed.')
    expect(page).not_to have_content('my first post edited')
    expect(page).not_to have_content('I wanna be a scala dev')

    sleep(sleepSeconds)

    visit '/posts'
    expect(page).not_to have_content('Post was successfully destroyed.')
    click_link('Destroy', match: :first)
    sleep(sleepSeconds)
    page.driver.browser.switch_to.alert.accept
    sleep(sleepSeconds)
    expect(page).to have_content('Post was successfully destroyed.')
    expect(page).not_to have_content('my second post edited')
    expect(page).not_to have_content('Scala is the best programing language in the universe.')
  end
end
