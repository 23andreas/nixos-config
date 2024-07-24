const audio = await Service.import("audio");

const icons = {
  0: "muted",
  33: "low",
  66: "medium",
  100: "high",
  9999: "overamplified",
};

export default () =>
  Widget.Button({
    className: "group",
    child: Widget.Icon().hook(audio.speaker, (self) => {
      const volume = audio.speaker.is_muted ? 0 : audio.speaker.volume * 100;

      const iconKey =
        Object.keys(icons)
          .map(Number)
          .find((key) => volume <= key) || 0;

      self.icon = `audio-volume-${icons[iconKey]}-symbolic`;
    }),
  });
