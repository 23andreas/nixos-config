import Volume from './Volume';
import Network from './Network';
import { Chip } from 'elements/index';

const SystemIndicators = () => {
  return Chip({
    spacing: 5,
    children: [Network(), Volume() ],
    classNames: ['secondary']
  });
};

export default SystemIndicators;
