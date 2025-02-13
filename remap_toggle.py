#!/usr/bin/env python3

# Swaps the left command key and control key when neovim is detected
# Used as an iterm2 AutoLaunch script
import iterm2
import asyncio
import logging
import os

# Set up logging
# logging.basicConfig(
#     level=logging.DEBUG,
#     filename=os.path.expanduser('~/iterm2_script.log'),
#     format='%(asctime)s - %(levelname)s - %(message)s'
# )

CONTROL_KEY = 1
LEFT_COMMAND_KEY = 7

async def main(connection):
    app = await iterm2.async_get_app(connection)
    
    async def update_remap(session):
        try:
            title = await session.async_get_variable("presentationName")
            logging.debug(f"Session title: {title}")
            
            if title and "nvim" in title.lower():
                logging.info("Neovim detected - enabling remap")

            else:
                logging.info("Neovim not detected - disabling remap")

        except Exception as e:
            logging.error(f"Error in update_remap: {str(e)}", exc_info=True)
            exit(1)

    async def monitor_sessions():
        while True:
            try:
                # Get the active session
                active_session = app.current_terminal_window.current_tab.current_session
                title = await active_session.async_get_variable("presentationName")
                logging.debug(f"Session title: {title}")
                logging.info(f"LeftCommand: {await iterm2.async_get_preference(connection, iterm2.PreferenceKey.LEFT_COMMAND_REMAPPING)}")
                if title and "nvim" in title.lower():
                    logging.info("Neovim detected - enabling remap")
                    if await iterm2.async_get_preference(connection, iterm2.PreferenceKey.LEFT_COMMAND_REMAPPING) == LEFT_COMMAND_KEY:
                        await iterm2.async_set_preference(connection, 'LeftCommand', CONTROL_KEY)

                    if await iterm2.async_get_preference(connection, iterm2.PreferenceKey.CONTROL_REMAPPING) == CONTROL_KEY:
                        await iterm2.async_set_preference(connection, 'Control', LEFT_COMMAND_KEY)
                else:
                    logging.info("Neovim not detected - disabling remap")
                    if await iterm2.async_get_preference(connection, iterm2.PreferenceKey.LEFT_COMMAND_REMAPPING) == CONTROL_KEY:
                        await iterm2.async_set_preference(connection, 'LeftCommand', LEFT_COMMAND_KEY)

                    if await iterm2.async_get_preference(connection, iterm2.PreferenceKey.CONTROL_REMAPPING) == LEFT_COMMAND_KEY:
                        await iterm2.async_set_preference(connection, 'Control', CONTROL_KEY)

            except Exception as e:
                logging.error(f"Error in monitor_sessions: {str(e)}", exc_info=True)
                exit(1)
            
            await asyncio.sleep(1)

    # Add error handling for the main loop
    try:
        await monitor_sessions()
    except Exception as e:
        logging.critical(f"Critical error in main loop: {str(e)}", exc_info=True)
        exit(1)
# Enable debug mode in iTerm2's Python API
iterm2.Connection.RUNNING_IN_PYTHON_RUNTIME = True

# Start the script with error handling
try:
    iterm2.run_forever(main)
except Exception as e:
    logging.critical(f"Failed to start script: {str(e)}", exc_info=True)