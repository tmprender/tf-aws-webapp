#!/bin/bash

apt-get -qy update &&
    apt-get -qy -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" install nginx &&
    apt-get -qy clean