# coding: utf-8
require "net/http"
require "json"

def projects
  ENV["AUTOREBASE_PROJECTS"].split(",")
end

def base_url
  # "https://hcp5-sources.int.esrlabs.com/a/changes/"
  "http://127.0.0.1:8080/a/changes/"
end
def user
  ENV["GERRITHOOKS_USER"]
end

def pass
  ENV["GERRITHOOKS_PASSWORD"]
end

def rebase(change_id, http_session)
  uri = URI("#{base_url}/#{change_id}/rebase")
  request = Net::HTTP::Post.new uri
  request.basic_auth user, pass
  response = http_session.request request
end

def run(args, io)
  project = args['--project']
  raise 'missing project' unless project
  params = [
    "project:#{project}",
    "is:open",
    "-is:mergeable",
    "label:Code-Review=2",
    "-label:Code-Review=-2"
  ].join("+")
  uri = URI("#{base_url}?q=#{params}")
  Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
    request = Net::HTTP::Get.new uri
    request.basic_auth user, pass
    response = http.request request
    changes = JSON.parse(response.body.split("\n", 2)[1])
    changes.each do |change|
      rebase(change["id"], http)
      io.puts("Rebased #{change["id"]}")
    end
   end
end