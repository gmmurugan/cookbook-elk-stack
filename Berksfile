source 'https://supermarket.chef.io'

# temporary use our branch until fix is merged upstream
cookbook 'java', git: 'https://github.com/tknerr/java.git', ref: 'extract-to-tmp'

# temporary workaround until hw-cookbooks/runit#148 is rebased and merged
# (only needed for running the integration tests with docker on circleci)
cookbook 'runit', git: 'https://github.com/ai-traders/runit', ref: '#60_in_docker_better'

metadata
