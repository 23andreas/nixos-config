interface Props {
  children: any;
  spacing?: number;
  classNames?: string[];
}

export const Chip = ({ children, classNames, spacing = 0}: Props) => {
  return Widget.Box({
    className: `chip ${classNames?.join(' ')}`,
    spacing,
    children,
  });
}

export default Chip;
