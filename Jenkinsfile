
node('docker') {

  def app = docker {
      image 'irishmarco/openwrt-builder:18.04'
      args  'e USER=jenkins'
    }
  }

  stage('Get repo') {
    checkout scm
  }

  stage('Prepare environment') {
    app.inside {
      sh '''#!/bin/bash
        set -xe

        id

        if [ ! -d openwrt ]; then
          git clone https://git.openwrt.org/openwrt/openwrt.git/ -b openwrt-18.06
        fi
        cd openwrt
        git pull
        pwd

        ./scripts/feeds update -a
        ./scripts/feeds install -a
      '''
      }
  }

  stage('VirtualBox i368') {
    app.inside {
     sh '''#!/bin/bash
        set -xe

        cd openwrt
        cp ../openwrt-18.01.x86_32.config .config
        make oldconfig
        make -j32 V=s
      '''
    }
  }

    stage('VirtualBox x64') {
      sh '''#!/bin/bash
        set -xe

        cd openwrt
        cp ../openwrt-18.01.x86_64.config .config
        make oldconfig
        make -j32 V=s
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
