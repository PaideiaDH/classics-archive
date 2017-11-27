import PropTypes from 'prop-types';
import React from 'react';
import Tag from './Tag';

export default class FeaturedArticle extends React.Component {
  render() {
    const article = this.props.article
    const fullName = `${article.author_first_name} ${article.author_last_name}`
    const imageTitle = `${article.title} by ${fullName}`
    const tags = article.tags.map(t => t.name).join(",")
    const classs=this.props.classs
    return (
      <div className={classs}>
        <img className="d-block w-100 carousel-image" src={article.image} alt={imageTitle} />
        <div className="carousel-caption d-none d-md-block">
          <i className="fa fa-external-link pull-right" aria-hidden="true" />
          <a href={article.url} target="_blank">
            <h3>
              {article.title}
            </h3>
            <h5>
              by {fullName} for {article.site_name}
            </h5>
            <p>
              {article.description}
            </p>
          </a>
        </div>
      </div>
    )
  }
}

FeaturedArticle.propTypes = {
  article: PropTypes.object.isRequired,
};
