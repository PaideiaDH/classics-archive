import React, { Component } from "react";
import FeaturedArticle from './FeaturedArticle'

export default class Carousel extends React.Component {
  render() {
    let articles = []
    let indicators = []
    this.props.articles.map((a, i) => {
      indicators.push(
        <li
          data-target="#carouselExampleIndicators"
          data-slide-to={i}
          className={i == 0? 'active' : ''}
        />
      )
      articles.push(
        <FeaturedArticle
          article={a}
          classs={i == 0? 'carousel-item active' : 'carousel-item'}
        />
      )
    })
    return (
      <div id="carouselExampleIndicators" className="carousel slide" data-ride="carousel">
        <ol className="carousel-indicators">
          {indicators}
        </ol>
        <div className="carousel-inner">
          {articles}
        </div>
        <a className="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
          <span className="carousel-control-prev-icon" aria-hidden="true"></span>
          <span className="sr-only">Previous</span>
        </a>
        <a className="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
          <span className="carousel-control-next-icon" aria-hidden="true"></span>
          <span className="sr-only">Next</span>
        </a>
      </div>
    );
  }
}
