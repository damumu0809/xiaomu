import React from 'react';
import ReactDom from 'react-dom';

import AwesomeComponent from './AwesomeComponent';

class App extends React.Component {
  render () {
    return (
      <div>
        <h1> Hello React!</h1>
        <AwesomeComponent />
      </div>
    );
  }
}

ReactDom.render(<App/>, document.getElementById('app'));
