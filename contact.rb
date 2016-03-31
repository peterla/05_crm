class Contact
  attr_reader :id # id is not modifiable by the user.
  attr_accessor :first_name, :last_name, :email, :note

 # Class variable, shared among all instances of Contact, and is a list of Contact objects.
  @@contacts = []

  # The Contact class makes sure that each Contact instance has a unique id
  # Globally unique across all the Contacts in the list
  @@next_id = 1

  # This method should take four string arguments (first_name, last_name, email, note),
  # and initialize this instance of Contact.
  def initialize(id, first_name, last_name, email, note)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end

  # This method should take four string arguments (first_name, last_name, email, note),
  # and return the newly created contact
  #def self.create(options)
  def self.create(first_name, last_name, email, note)
    # 1. Make a new Contact
    #new_contact = new(id, options[:first_name], options[:last_name], options[:email], options[:note])
    new_contact = new(@@next_id, first_name, last_name, email, note)

    # 2. Add it to the list of contacts (@@contacts)
    @@contacts << new_contact

    # 3. Increment the global id
    @@next_id += 1

    # 4. Return the new contact, which makes more sense then returning the id of the next object that will be created
    new_contact
  end

  # This method takes no arguments
  # and return all of the existing contacts in array form
  def self.all
    @@contacts
  end

  # This method should take an integer id argument
  # and return the contact that corresponds to the id
  def self.find(id)
    @@contacts.each do |contact|
      if contact.id == id then
        return contact
      end
    end
    return nil
  end

  # This method should take two string arguments (attribute, value)
  # It should look for the contact with the attribute corresponding to the value
  # and return that contact
  #
  # For example:
  #   Contact.find_by('first_name', 'Joe')
  # should return an array of ALL matching Contacts with first_name 'Joe'
  def self.find_by(attribute, value)
    result = []
    @@contacts.each do |contact|
      if contact.instance_variable_get("@#{attribute}") == value
        result << contact
      end
    end
    return result # Empty array if no matching Contacts found
  end

  # This method takes no arguments
  # It should delete all of the contacts from memory
  def self.delete_all
    @@contacts.clear
  end

  # def self.delete_by_id(id)
  #   @@contacts.each do |contact, index|
  #     if contact.id == id
  #       @@contacts.delete_at(index)
  #     end
  #   end
  #   false
  # end

  # This method takes no arguments
  # It should return a string that is composed of the first and last names of the contact.
  def full_name
    "#{first_name} #{last_name}"
  end

  # This method should take two string arguments (attribute, value)
  # It should update the current instance of contact with the new value of the attribute
  #
  # For example:
  #   mary.update('email', 'mary_new_email@gmail.com')
  # should update mary's email address to the new one.
  def update(attribute, value)
    instance_variable_set("@#{attribute}", value)
  end

  # This method takes no arguments
  # It should delete the current instance of contact from memory
  def delete
    @@contacts.delete(self)
  end

end
