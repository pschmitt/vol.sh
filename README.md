# vol.sh

Volument control and notification (PulseAudio and volnoti)

## Dependencies

- [pamixer](https://github.com/cdemoulins/pamixer)
- [volnoti](https://github.com/davidbrazdil/volnoti)

## Usage

```bash
# Increase volume (default step: 5)
vol.sh i
# Increase volume by 10
vol.sh i 10
# Decrease volume (default step: 5)
vol.sh d
# Decrease volume by 10
vol.sh d 10
# Mute
vol.sh m
# Increase volume by 10 but don't show notification
vol.sh i 10 nope
```
