import React from 'react';
import _ from 'lodash';

export default class Loader extends React.Component {
  render() {
    const times = Math.floor(this.props.width / 20)
    let card = [];
    _.times(times, () => {
      card.push(<img src="/assets/running.gif" className='running-roman' />)
    });

    return (
      <div id="runningRomans">
        {card}
      </div>
    );
  }
}
