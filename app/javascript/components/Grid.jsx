import React, { Component } from "react";
import StackGrid from "react-stack-grid";
import Article from './Article';
import FeaturedArticle from './FeaturedArticle';

export default class Grid extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      page: this.props.page,
      articles: this.props.articles,
      numArticles: this.props.numArticles,
      query: this.props.query,
      hasMore: true,
      cardWidth: '33.33%',
      renderedWidth: 500,
      featured_article: undefined
    };
    this.getCardWidth = this.getCardWidth.bind(this)
    this.feature = this.feature.bind(this)
  }

  getCardWidth() {
    if (window.innerWidth <= 500) {
      this.setState({ cardWidth: '100%' });
    } else if (window.innerWidth <= 1000) {
      this.setState({ cardWidth: '50%' });
    } else {
      this.setState({ cardWidth: '33.33%' });
    }
  }

  feature() {
    const articles = this.state.articles
    const features = articles.filter(a => a.feature == true);
    const feat = (features.length) ? features[0] : articles[0]
    const ind = articles.indexOf(feat)
    const new_arr = articles.splice(ind, 1)
    this.setState({
      featured_article: feat,
      articles: new_arr,
    })

  }

  componentDidMount() {
    this.setState({renderedWidth: this.divElement.clientWidth})
    this.getCardWidth();
    window.addEventListener('resize', this.getCardWidth);
  }

  render() {
    let items = [];
    this.state.articles.map((article, i) => {
      items.push(
        <Article
          key={article.id}
          article={article}>
        </Article>
      );
    });
    return (
      <div ref={ (divElement) => this.divElement = divElement}>
        <br />
        <StackGrid
          columnWidth={this.state.cardWidth}
          gutterWidth={12}
          gutterHeight={12}
          monitorImagesLoaded={true}
        >
          {items}
        </StackGrid>
      </div>
    );
  }
};
