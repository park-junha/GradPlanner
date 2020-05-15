import React, {Component} from 'react';
import LandingPage from './LandingPage';
import AboutPage from './AboutPage';
//import GroceryList from './GroceryList';
import logo from './logo.svg';
import './App.css';

class App extends Component{
  render() {
    return (
      <div className="App">
        App Component
        <LandingPage />
        <AboutPage />
      </div>
    );
  }
}

export default App;
