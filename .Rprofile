tryCatch({
  # If renv is not installed, install it first
  if (!suppressPackageStartupMessages(require("renv", quietly = TRUE))) {
    install.packages("renv")
  }
  # Try to activate the renv environment
  source("renv/activate.R") |> suppressMessages() |> suppressWarnings()
},
error = function(e) {
  opt <- options(show.error.messages = FALSE)
  on.exit(options(opt))
  cat("\014")
  stop(cat(paste0(
    "------------------------------------------------------------\n",
    "                  Welcome to this project!                  \n",
    "------------------------------------------------------------\n",
    "To make the analyses conducted in the project reproducible, \n",
    "this project is endowed with its own environment using the  \n",
    "`renv` package. This means that the project aims to use its \n",
    "own version of the packages independently from your\n",
    "computer by installing them in the folder it's located in.  \n",
    "------------------------------------------------------------\n",
    "\n",
    "This requires installing and activating `renv`, which is    \n",
    "normally done automatically for you on startup. However,    \n",
    "these operations just failed.\n",
    "This might be due to your computer being offline.\n",
    "If you want to use the exact same environment the project   \n",
    "was coded in (the recommended option), please find an       \n",
    "internet connection and restart R. If your internet         \n",
    "connection is ok, this might be an unexpected bug. You can  \n",
    "try to run source('renv/activate.R') manually to see if it  \n",
    "works, and try to run install.packages('renv') if it        \n",
    "doesn't.\n",
    "\n",
    "In any case, if things are fixed you should see new messages\n",
    "when starting R.\n",
    "\n",
    "Else, you can start working on the project right away, but  \n",
    "note that you will use the packages currently installed on  \n",
    "your computer. These could potentially be different versions\n",
    "than those used when the code was developed, meaning the    \n",
    "functions might behave differently from what was initially  \n",
    "intended."
  )))
})

.First <- function() {
  if (interactive()) {
    if (!suppressMessages(suppressWarnings(renv::status()$synchronized))) {

      # Check if the R version is the same
      r_local <- paste0(R.version$major, ".", R.version$minor)
      r_lockfile <-
        renv::status()$lockfile$R$Version |>
        suppressMessages() |>
        suppressWarnings()
      cat("\014")

      cat(paste0(
        "-----------------------------------------------------------\n",
        "                  Welcome to this project!                 \n",
        "-----------------------------------------------------------\n",
        "To make the analyses conducted in the project reproducible,\n",
        "this project is endowed with its own environment using the \n",
        "`renv` package. This means that the project aims to use its\n",
        "own version of the packages independently from your\n",
        "computer by installing them in the folder it's located in. \n",
        "-----------------------------------------------------------\n",
        "\n"
      ))

      # If the R version doesn't match, print a message with recommendations
      if (r_local != r_lockfile) {
        switch(
          utils::menu(
            title = paste0(
              "The `renv` reproducible environment is currently activated \n",
              "but the R version recorded in the lockfile (R ", r_lockfile,") ",
              "is\ndifferent from the one you are using (R ", r_local, ").\n",
              "This may or may not cause issues with some packages.       \n",
              "\n",
              "I recommend installing the R version recorded in the       \n",
              "lockfile, switching to this version and restarting RStudio \n",
              "and the project. Else, you can try to use the project with \n",
              "your current R version, you but might run into unexpected  \n",
              "issues.\n",
              "\n",
              "Do you want to keep going with your R version and try to   \n",
              "synchronise the recorded packages anyway?"
            ),
            choices = c(
              "Yes, try to synchronise packages (other prompts will follow)",
              paste0("No, I want to install the R version recorded in the\n",
                     "   lockfile first (recommended)")
            )
          ),
          cat(paste0(
            "Ok, let's see what's going on then:\n",
            "-----------------------------------\n\n"
          )),
          {
            opt <- options(show.error.messages = FALSE)
            on.exit(options(opt))
            stop(
              cat(paste0(
                "You chose...Wisely. From there, I recommend:\n",
                "1. Installing the R version recorded in the lockfile ",
                "(mentioned above)\n",
                "2. Changing the R version\n",
                "   ('Tools' -> 'Global options' -> 'General' -> 'R version' ",
                "in RStudio)\n",
                "3. Restarting RStudio and the project\n",
                "4. Following the new instructions that appear!"
              ))
            )
          }
        )
      }
      # If the library is not synchronised, print a message and offer to
      # fix things automatically -----------------------------------------------
      cat(paste0(
        "The `renv` reproducible environment is activated but some\n",
        "packages are not synchronised between the recorded list of \n",
        "packages (the lockfile) and your local project's library.\n",
        "Here's what's going on (using renv::status()):\n",
        "----------------------------------------------\n\n"
      ))
      renv::status() |> suppressMessages() |> suppressWarnings()
      switch(
        utils::menu(
          title = paste0(
            "\n",
            "--------------------------------------------------------\n",
            "... No need to go to the help page, we can fix this with\n",
            "a sequence of operations that should cover all possibilities:",
            "\n\n",
            "1. Remove unused packages from the local library\n",
            "2. Restore the packages recorded in the lockfile\n",
            "3. Install the packages in the scripts that aren't recorded\n",
            "4. Record the new state of all the packages in the lockfile.\n",
            "Theoretically, this should be enough to synchronise everything.",
            "\n\n",
            "Should we run this sequence of operations?"
          ),
          choices = c("Yes", "No")
        ),
        # If they accept, give a summary and another prompt --------------------
        {
          cat(paste0(
            "\n",
            "1. Remove unused packages from the library (renv::clean()):\n",
            "-----------------------------------------------------------\n",
            "\n"
          ))
          renv::clean(prompt = FALSE)

          cat(paste0(
            "\n",
            "2. Restore the packages from the lockfile (renv::restore()):\n",
            "------------------------------------------------------------\n",
            "\n"
          ))
          renv::restore(prompt = FALSE, clean = TRUE)

          cat(paste0(
            "\n",
            "3. Install the packages that aren't recorded (renv::install()):",
            "\n",
            "---------------------------------------------------------------",
            "\n\n"
          ))
          renv::install(prompt = FALSE)

          cat(paste0(
            "\n",
            "4. Record all the packages in the lockfile (renv::snapshot()):",
            "\n",
            "--------------------------------------------------------------",
            "\n\n"
          ))
          renv::snapshot(prompt = FALSE)

          # Set auto snapshot to ease the mental burden of keeping track of
          # all package changes
          options(renv.config.auto.snapshot = TRUE)

          cat(paste0(
            "\n",
            "Is everything sychronised? (renv::status()):\n",
            "--------------------------------------------\n",
            "\n"
          ))
          renv::status() |> suppressMessages() |> suppressWarnings()

          cat(paste0(
            "\n",
            "|-> If everything's fixed, you can restart R to see new ",
            "welcome messages :)\n"
          ))
        },
        # If they decline, print a little warning and exit ---------------------
        cat(paste0(
          "\n",
          "Ok, but be careful with the packages you use!\n",
          "See renv::status() for more details about your project\n",
          "library's synchronisation status.\n\n"
        ))
      )
    } else {
      # Set auto snapshot to ease the mental burden of keeping track of
      # all package changes
      options(renv.config.auto.snapshot = TRUE)

      # devtools is central for package development
      if (!suppressPackageStartupMessages(
        require("devtools", quietly = TRUE)
      )) {
        renv::install("devtools", prompt = FALSE, verbose = FALSE)
      }
      library("devtools", quietly = TRUE)

      cat("\014")
      anew <- sample(c(
        "Let us cook.     ",
        "Born anew.       ",
        "A new beginning. ",
        "Fresh and clean. ",
        "Fresh, so fresh. "
      ), 1)
      cat(paste0(
        "--------------------------------------------------------\n",
        "|-> All installed packages are recorded and vice versa.\n",
        "|   Reproducible project environment, ready for action!\n",
        "--------------------------------------------------------\n",
        " Here we go... ", anew, "\n"
      ))
    }
  }
}

.Last <- function() {
  if (interactive()) {
    cat("\014")
    cat(paste0(
      "\n",
      "|---------------------------------------|\n",
      "|-> Session closed. Until next time! o/ |\n",
      "|---------------------------------------|"
    ))
    Sys.sleep(0.75)
  }
}
