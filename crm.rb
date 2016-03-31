# Can use require or require_relative here
require_relative 'contact.rb'

class CRM

  def main_menu
    while true
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then exit(true) # Exit with success status, meaning a normal exit
    end
  end

  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp

    print 'Enter Last Name: '
    last_name = gets.chomp

    print 'Enter Email Address: '
    email = gets.chomp

    print 'Enter a Note: '
    note = gets.chomp

    Contact.create(first_name, last_name, email, note)
  end

  def modify_existing_contact
    puts "Enter the id of contact to be modified: "
    user_entered_id = gets.to_i

    puts "You entered an id of #{user_entered_id}. Is this correct? (yes or no)"
    user_entered_yes_or_no = gets.chomp

    if user_entered_yes_or_no == "yes"
      contact = Contact.find(user_entered_id)
      if contact != nil
        print "\nContact found:\n\n"
        print "#{contact.full_name} (id: #{contact.id})\n"
        print "Email: #{contact.email}\n"
        print "Note: #{contact.note}\n\n"

        puts '[1] First name'
        puts '[2] Last name'
        puts '[3] Email'
        puts '[4] Note'
        puts 'Select an attribute to modify: '
        user_selected = gets.to_i

        case user_selected
        when 1
          puts "Enter new first name: "
          new_first_name = gets.chomp
          contact.first_name = new_first_name
        when 2
          puts "Enter new last name: "
          new_last_name = gets.chomp
          contact.last_name = new_last_name
        when 3
          puts "Enter new email: "
          new_email = gets.chomp
          contact.email = new_email
        when 4
          puts "Enter new note: "
          new_note = gets.chomp
          contact.note = new_note
        end
      else
        puts "Contact not found."
      end
    end
  end

  def delete_contact
    print 'Enter id of contact to be deleted: '
    id = gets.to_i

    contact = Contact.find(id)
    if contact != nil
      puts "CLASS: #{contact.class}"
      contact.delete
      puts "Contact deleted."
    else
      puts "Contact not found."
    end
  end

  def display_all_contacts
    if Contact.all.size > 0
      print "\nList of Contacts\n\n"

      Contact.all.each do |contact|
        print "#{contact.full_name} (id: #{contact.id})\n"
        print "Email: #{contact.email}\n"
        print "Note: #{contact.note}\n\n"
      end
    else
      print "\nYour Contacts List is Empty.\n\n"
    end
  end

  def search_by_attribute
    puts '[1] First name'
    puts '[2] Last name'
    puts '[3] Email'
    puts '[4] Note'
    puts 'Select an attribute by number: '
    user_selected = gets.to_i

    attributes = [ "first_name", "last_name", "email", "note" ]
    if user_selected > 0 && user_selected < 5
      puts "Enter value for #{attributes[user_selected - 1]}: "
      value = gets.chomp

      matching_contacts = Contact.find_by(attributes[user_selected - 1], value)

      # If we found 1 or more contacts, display them
      if matching_contacts.size > 0
        puts
        puts "Matches found: "
        puts

        matching_contacts.each do |contact|
          puts "#{contact.full_name} (id #{contact.id})"
          puts "Email: #{contact.email}"
          puts "Note: #{contact.note}"
          puts
        end
      else
        puts "\nSorry, no matches found! :'(\n"
      end
    else
      puts 'You did not select a valid attribute.'
    end
  end

end

myCRM = CRM.new
myCRM.main_menu
