// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChainRep {
    uint256 public reviewCount;

    struct Review {
        uint256 id;
        uint256 rating;
        string description;
        string category;
        address reviewer;
        address reviewed;
    }

    struct User {
        address userAddress;
        uint256 reviewsReceivedCount;
        uint256 totalRating;
        uint256 rawRatingScore;
    }

    mapping(address => User) public userProfile;
    mapping(uint256 => Review) public singleReview;
    event Reviewed(address reviewer, address indexed reviewed, Review review);

    function createReview(
        uint256 _rating,
        string memory _description,
        string memory _category,
        address _reviewer,
        address _reviewed
    ) public {
        reviewCount++;
        singleReview[reviewCount] = Review(
            reviewCount,
            _rating,
            _description,
            _category,
            _reviewer,
            _reviewed
        );
        Review memory review = singleReview[reviewCount];
        User storage reviewed = userProfile[_reviewed];
        // Check if user profile has been initialized
        if (reviewed.reviewsReceivedCount > 0) {
            reviewed.reviewsReceivedCount++;
            reviewed.rawRatingScore += review.rating;
            reviewed.totalRating = (reviewed.rawRatingScore /
                reviewed.reviewsReceivedCount);
        } else {
            // initialize user profile if it doesn't exist
            reviewed.userAddress = _reviewed;
            reviewed.reviewsReceivedCount++;
            reviewed.totalRating = review.rating;
            reviewed.rawRatingScore = review.rating;
        }
        emit Reviewed(_reviewer, _reviewed, singleReview[reviewCount]);
    }

    function getUserTotalRating(address _user) public view returns (uint256) {
        User memory user = userProfile[_user];
        return user.totalRating;
    }

    function getUserCategoryRating(address _reviewed, string memory _category)
        public
        view
        returns (uint256)
    {
        uint256 userCategoryReviewCount;
        uint256 categoryRating;
        for (uint256 i = 1; i < reviewCount; i++) {
            Review memory review = singleReview[i];
            if (
                (keccak256(abi.encodePacked((review.category))) ==
                    keccak256(abi.encodePacked((_category)))) &&
                review.reviewed == _reviewed
            ) {
                userCategoryReviewCount++;
                categoryRating += review.rating;
            }
        }
        return categoryRating / userCategoryReviewCount;
    }
}
