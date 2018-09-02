
node('docker') {
  timestamps {
    wrap([$class: 'AnsiColorBuildWrapper', colorMapName: 'xterm']) {
      stage('Environment') {

        checkout scm

        def env = docker.image('irishmarco/openwrt-builder:18.04')

        env.inside("") {
          withEnv([
            "VERSION=1"
          ]) {
              stage('Prepare environment') {
                sh '''#!/bin/bash
                  set -xe

		  id

                  if [ ! -d openwrt ]; then
                    git clone https://git.openwrt.org/openwrt/openwrt.git/ -b openwrt-18.06
                  fi
                  cd openwrt
                  git pull
                  pwd

                  ../docker-wrapper.sh ./scripts/feeds update -a
                  ../docker-wrapper.sh ./scripts/feeds install -a
                '''
              }

              stage('VirtualBox i368') {
                sh '''#!/bin/bash
                  set -xe

                  cd openwrt
                  cp ../openwrt-18.01.x86_32.config .config
                  ../docker-wrapper.sh make oldconfig
                  ../docker-wrapper.sh make -j32 V=s
                '''
              }

              stage('VirtualBox x64') {
                sh '''#!/bin/bash
                  set -xe

                  cd openwrt
                  cp ../openwrt-18.01.x86_64.config .config
                  ../docker-wrapper.sh make oldconfig
                  ../docker-wrapper.sh make -j32 V=s
                '''
              }

              stage('RaspberryPi') {
                sh '''#!/bin/bash
                  set -xe

                  cd openwrt
                  cp ../openwrt-18.01.raspberrypi.config .config
                  make oldconfig
                  make -j32 V=s
                '''
              }

              stage('Pine64') {
                sh '''#!/bin/bash
                  set -xe

                  cd openwrt
                  cp ../openwrt-18.01.pine64.config .config
                  make oldconfig
                  make -j32 V=s
                '''
              }
          }
        }
      }
    }
  }
}
