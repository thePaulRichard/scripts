#!/bin/sh

for profile in $(awk -F'[][]' '{print $2}' ~/.aws/credentials); do echo $profile; done
