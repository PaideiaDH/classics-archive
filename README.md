[![Online Public Classics Archive](https://github.com/kamillamagna/classics-archive/blob/master/app/assets/images/Paideia_Archive_2.jpg?raw=true 'OPCA')](http://opca.paideiainstitute.org/)

## Description
The [Online Public Classics Archive](http://opca.paideiainstitute.org/articles) is a research repository for modern scholarship about the Classical world.

Built by [Kamille Delgardo](http://kamille.delgardo.co/) as a 2017 Digital Humanities Fellow for [The Paideia Institute](http://www.paideiainstitute.org) with co-sponsorship by the [Society for Classical Studies](https://classicalstudies.org/).

## Methodology
The Archive was featured at the [2018 Annual Meeting of the Society for Classical Studies in Boston](https://classicalstudies.org/annual-meeting/2018-annual-meeting):
> Classics has had a strong presence in the press. As Hardwick and Harrison (2013) remark, “Greek and Roman texts, material culture and ideas have always been widely and radically used and re-used by individuals and by societies, and in recent centuries this has gradually included more people who have not had a formal classical education of any kind.” More recently, popular culture and the media have engaged with antiquity for centuries (cf. Jenkins 2015), yet it is currently difficult to search for and document the places where that engagement takes place. One can Google “Plato and Trump” or “Xenophon and leadership”, but the search results can often be too unwieldy and lacunose to be of much productive use.
>
> In order to document the great collective impact that our discipline has had and continues to have on public ways of thinking, we have created the Online Public Classics Archive, a public media Classics database that archives and organizes the public media engagement with antiquity on the Internet. This e-resource is linked to the way we search on the Internet. If someone wants to search for "Epictetus” in Google, one sees the Wikipedia entry and a few other philosophy e-resources on the first search page. If one filters search results through the “news” option, one sees some recent blog posts and articles. But what if one wants to find out how many times reporters, columnists, bloggers, and other public writers have discussed Epictetus from 2007-2017? On a daily basis we see many of these articles circulating on social media but they often end up sitting alone and abandoned as bookmarks or downloaded PDFs only on our own computers.
>
> Our database succeeds in providing a space (that is searchable by keywords and tags and can be filtered by date) for both Classicists and the public to examine just how much of an impact the ancient world has had on contemporary thought. Though it is currently in the initial stages of development, it is already clear that a substantial body of public scholarship discussing antiquity has a robust and important presence in public discourse.

#### Bibliography:
* Hardwick, L. and Harrison, S. eds. 2013. Classics in the Modern World: A Democratic Turn? Oxford.
* Jenkins, T. 2015. Antiquity Now: the Classical World in the Contemporary American Imagination. Cambridge.


## Technologies Used
* MVC with [Ruby on Rails 5](https://github.com/rails/rails)
* Pinterest-style masonry front-end with [React.js](https://reactjs.org/), [Bootstrap 4](https://getbootstrap.com/), and [jQuery](https://jquery.com/)
* Asset bundling with [Webpack](https://webpack.js.org/)
* Served with [Apache2](https://httpd.apache.org/) and [Passenger](https://www.phusionpassenger.com/) on the [Rackspace Cloud](https://www.rackspace.com/en-us)
* [PostgreSQL 9](https://www.postgresql.org/) production database.
* Robust search, sort and filter with [Filterrific](https://github.com/jhund/filterrific) and [Elasticsearch](https://github.com/ankane/searchkick)
* Entity tagging with [Reuters OpenCalais API](http://www.opencalais.com/) and [Aylien Text Analysis API](https://aylien.com/)
* User authentication and authorization with [Google OAuth 2.0](https://developers.google.com/identity/protocols/OpenIDConnect)
* Tagging with [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on) and [Select2](https://select2.org/)
* Issue tracking, feature management and service through [Jira Software and Service Desk](https://www.atlassian.com/software/jira)

## Contribute
Tweet content links to us at [@PublicClassics](https://twitter.com/PublicClassics).

[Share articles with our editorial staff](https://accounts.google.com/signin/oauth/oauthchooseaccount?client_id=415150494328-2k2h1o47fql3vh79s3a8ennakbfopqtk.apps.googleusercontent.com&as=-75f34e5f064627b0&destination=http%3A%2F%2Fopca.paideiainstitute.org&approval_state=!ChRDV3JaVk85WmIzWFo5TVkteERMORIfRTVxdWR6SFlEc3NWb1Bud0gtVkU1UUdtam5sRV9CVQ%E2%88%99AHw7d_cAAAAAWg6zs7aGXoVfqF83z_VE57aNioT3GaqG&xsrfsig=AHgIfE_uzUtLEmzk60SDRs6ICdRh-uQRfg&flowName=GeneralOAuthFlow).

Article metadata shared for scholarship and research purposes under [Fair Use](https://www.copyright.gov/fair-use/more-info.html).
