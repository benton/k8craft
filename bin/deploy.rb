#!/usr/bin/env ruby
# uses the kubectl tool to deploy k8craft
require 'yaml'
require 'open3'

TOP_DIR = File.expand_path(File.dirname(File.dirname(__FILE__)))
PRI_KEY = "#{ENV['HOME']}/.ssh/k8craft-key"
PUB_KEY = "#{PRI_KEY}.pub"

# Runs a command and prints STDOUT/STDERR. Exits on error, or returns STDOUT.
def run_cmd(cmd)
  stdout, stderr, status = Open3.capture3(cmd)
  puts stdout unless stdout.empty?
  puts stderr unless stderr.empty?
  exit 1 unless status
  stdout
end

unless File.exists?(PRI_KEY)
  puts "Creating keypair #{PRI_KEY}..."
  run_cmd("ssh-keygen -t rsa -f #{PRI_KEY}")
end

puts "Inserting public SSH key from #{PUB_KEY} into k8-deployment.yaml..."
kubedata = YAML.load(File.read "#{TOP_DIR}/k8-deployment.yaml")
kubedata['spec']['template']['spec']['containers'].
  find{|c| c['name'] == 'ssh'}['env'].
    find{|v| v['name'] == 'SSH_KEY'}['value'] = File.read(PUB_KEY)
OUTPATH = "#{TOP_DIR}/tmp/k8-deployment.yaml"
File.open(OUTPATH, "w") {|f| f.write(YAML.dump(kubedata))}

puts "Deploying k8craft from contents of #{OUTPATH}..."
run_cmd("kubectl create -f #{OUTPATH}")
run_cmd("kubectl expose deployment k8craft --type='LoadBalancer'")

# Wait for availability of external IP address
cmd = "kubectl describe service k8craft | grep 'LoadBalancer Ingress' | cut -f 2"
ip  = run_cmd(cmd)
puts "Waiting for external IP address - this can take about a minute..."
while ip.empty?
  print "."
  sleep 5
  ip = run_cmd(cmd)
end
puts "===================================================="
puts "Your private SSH key is:"
puts "===================================================="
puts File.read(PRI_KEY)
puts "===================================================="
puts "Your Minecraft server IP is: #{ip}"
puts "===================================================="
