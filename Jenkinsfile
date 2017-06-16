@Library('libpipelines@master') _

hose {
    EMAIL = 'qa'
    MODULE = 'docker-selenium-chrome'
    REPOSITORY = 'docker-selenium-chrome'
    SLACKTEAM = 'stratiopaas'
    BUILDTOOL = 'make'
    DEVTIMEOUT = 45
    PKGMODULESNAMES = ['selenium-chrome']

    DEV = { config ->        
        doDocker(config)
     }
}
