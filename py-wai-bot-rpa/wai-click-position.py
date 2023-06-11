from pynput import mouse

print("Click the screen to see the position...")

def on_click(x, y, button, pressed):
    if pressed:
        # Print position of click
        print('pyautogui.click({0}, {1})'.format(int(x), int(y)))

# Collect events until released
with mouse.Listener(on_click=on_click) as listener:
    listener.join()
