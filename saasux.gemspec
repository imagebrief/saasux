# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "saasux"
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Peterson"]
  s.date = "2013-06-12"
  s.description = "Ruby XML interface to Saasu API"
  s.email = "dhpeterson@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/saasux.rb",
    "lib/saasux/driver.rb",
    "lib/saasux/entities.rb",
    "lib/saasux/entities/address.rb",
    "lib/saasux/entities/contact.rb",
    "lib/saasux/entities/email_message.rb",
    "lib/saasux/entities/invoice.rb",
    "lib/saasux/entities/invoice_items.rb",
    "lib/saasux/entities/invoice_payment.rb",
    "lib/saasux/entities/item_invoice_item.rb",
    "lib/saasux/entities/service_invoice_item.rb",
    "lib/saasux/entities/trading_terms.rb",
    "lib/saasux/messages.rb",
    "lib/saasux/messages/contact_response.rb",
    "lib/saasux/messages/delete_result.rb",
    "lib/saasux/messages/email_pdf_invoice.rb",
    "lib/saasux/messages/email_pdf_invoice_result.rb",
    "lib/saasux/messages/error.rb",
    "lib/saasux/messages/errors.rb",
    "lib/saasux/messages/insert_contact.rb",
    "lib/saasux/messages/insert_contact_result.rb",
    "lib/saasux/messages/insert_invoice.rb",
    "lib/saasux/messages/insert_invoice_result.rb",
    "lib/saasux/messages/invoice_response.rb",
    "lib/saasux/messages/tasks.rb",
    "lib/saasux/messages/tasks_response.rb",
    "lib/saasux/messages/update_contact.rb",
    "lib/saasux/messages/update_contact_result.rb",
    "lib/saasux/messages/update_invoice.rb",
    "lib/saasux/messages/update_invoice_result.rb",
    "lib/saasux/support.rb",
    "lib/saasux/support/formatter.rb",
    "saasux.gemspec"
  ]
  s.homepage = "http://github.com/peterson/saasux"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Ruby XML interface to Saasu API"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<xml-mapping>, [">= 0.9.1"])
      s.add_runtime_dependency(%q<httparty>, [">= 0.9.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<webmock>, ["~> 1.8.10"])
    else
      s.add_dependency(%q<xml-mapping>, [">= 0.9.1"])
      s.add_dependency(%q<httparty>, [">= 0.9.0"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.2.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<webmock>, ["~> 1.8.10"])
    end
  else
    s.add_dependency(%q<xml-mapping>, [">= 0.9.1"])
    s.add_dependency(%q<httparty>, [">= 0.9.0"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.2.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<webmock>, ["~> 1.8.10"])
  end
end
