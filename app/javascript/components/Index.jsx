import React from 'react';
import PropTypes from 'prop-types';
import Grid from './Grid';

export default class Index extends React.Component {
  constructor(props) {
    super(props);

    this.sortBy = this.sortBy.bind(this)
  }
  // sortBy(option, e) {
  //   e.preventDefault();
  //   let func;
  //   switch (option) {
  //     case 'author':
  //       func = (a, b) =>
  //         a.author_last_name.localeCompare(b.author_last_name)
  //       )
  //       break;
  //     default:
  //
  //   }
  //   this.setState((prevState) => {
  //     articles: prevState.articles.sort(func)
  //   }
  // }

  render() {
    const sortOptions = []
    return (
      <div class="form-group top-bar">
        <div class="input-group" area-de>
          <div id="allTags" data-alltags="<%= ActsAsTaggableOn::Tag.all.order(taggings_count: :desc).map(&:name).join(',') %>"></div>
          <input class="form-control" placeholder="Full-text search" type="text" name="[with_query]" id="with_query"  aria-describedby="resetFilters" />
          <input type="hidden" name="[with_tag]" id="with_tag" />
          <a href="#" id="calWidget" class="contains-fa">
            <i class="fa fa-calendar"></i>
          </a>
          <input type="hidden" name="[published_since]" id="published_since" />
          <a href="/articles/manage" class="contains-fa">
            <i class="fa fa-plus" aria-hidden="true"></i>
          </a>
          <a href="/signout" id="sign_out" class="contains-fa">
            <i class="fa fa-sign-out" aria-hidden="true"></i>
          </a>
          <a href="/auth/google_oauth2" id="sign_in" class="contains-fa">
            <i class="fa fa-sign-in" aria-hidden="true"></i>
          </a>
        </div>
        <div id="filterrificInfo">
          <small id="resetFilters">
            <b id="entriesInfo">
              ENTRIES INFO
            </b>
            sorted by
            <select name="[sorted_by]" id="sorted_by">
              sortOptions.map(opt =>
                <option
                  value={opt}
                  onClick={sortBy(opt)}
                >
                  {opt}
                </option>
              )
            </select>
            <div id="currentFilters" style="display:inline">
            </div>
            <a class="text-muted pull-right" id="resetFilters" href="/articles?filterrific%5Breset_filterrific%5D=true">
              Reset filters
            </a>
          </small>
        </div>
      </div>
    );
  }
}

Index.propTypes = {

};
