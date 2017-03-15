@Library('libpipelines@master') _

hose {
    EMAIL = 'qa'
    MODULE = 'docker-selenium-chrome'
    REPOSITORY = 'docker-selenium-chrome'
    SLACKTEAM = 'stratiopaas'
    DEVTIMEOUT = 45
    PKGMODULESNAMES = ['docker-selenium-chrome']

    DEV = { config ->        
        doDocker(config)
     }
}
