# coding: utf-8
require "net/http"
require "json"

def projects
  ENV["AUTOSUBMIT_PROJECTS"].split(",")
end

def base_url
  #"https://hcp5-sources.int.esrlabs.com/a/changes/"
  "http://127.0.0.1:8080/a/changes/"
end
def user
  ENV["GERRITHOOKS_USER"]
end

def pass
  ENV["GERRITHOOKS_PASSWORD"]
end

def has_author_review?(change)
  owner = change["owner"]["_account_id"]
  reviewers  = change["labels"]["Code-Review"]["all"]
               .select { |review| review["value"] == 2 }
               .map { |review| review["_account_id"] }
  reviewers.include? owner
end

def submit(change_id, http_session)
  uri = URI("#{base_url}/#{change_id}/submit")
  request = Net::HTTP::Post.new uri
  request.basic_auth user, pass
  response = http_session.request request
end

def run(args, io)
  project = args['--project']
  raise 'missing project' unless project
  params = "o=SUBMITTABLE&o=DETAILED_LABELS&q=project:#{project}+is:open+is:mergeable"
  uri = URI("#{base_url}?#{params}")
  Net::HTTP.start(uri.host, uri.port, :use_ssl => false) do |http|
    request = Net::HTTP::Get.new uri
    request.basic_auth user, pass
    response = http.request request # Net::HTTPResponse object
    changes = JSON.parse(response.body.split("\n", 2)[1])
    changes.each do |change|
      if has_author_review?(change)
        submit(change["id"], http)
        io.puts("Submitted #{change["id"]}")
      end
    end
   end
end